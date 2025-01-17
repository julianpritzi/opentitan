// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0

class sysrst_ctrl_scoreboard extends cip_base_scoreboard #(
  .CFG_T(sysrst_ctrl_env_cfg),
  .RAL_T(sysrst_ctrl_reg_block),
  .COV_T(sysrst_ctrl_env_cov)
);
  `uvm_component_utils(sysrst_ctrl_scoreboard)

  // local variables

  // Intr checks
  local bit [NUM_MAX_INTERRUPTS-1:0] intr_exp;
  local bit [NUM_MAX_INTERRUPTS-1:0] intr_exp_at_addr_phase;

  virtual  sysrst_ctrl_cov_if   cov_if;           // handle to sysrst_ctrl coverage interface

  // local queues to hold incoming packets pending comparison

  `uvm_component_new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    // TODO: remove once support alert checking
    do_alert_check = 0;
    if (!uvm_config_db#(virtual sysrst_ctrl_cov_if)::get(null, "*.env" ,
        "sysrst_ctrl_cov_if", cov_if)) begin
      `uvm_fatal(`gfn, $sformatf("FAILED TO GET HANDLE TO COVER IF"))
    end
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    fork
    join_none
  endtask

  virtual task process_tl_access(tl_seq_item item, tl_channels_e channel, string ral_name);
    uvm_reg        csr;
    bit            do_read_check = 1'b1;
    bit            write = item.is_write();
    uvm_reg_addr_t csr_addr = cfg.ral_models[ral_name].get_word_aligned_addr(item.a_addr);

    bit            addr_phase_read = (!write && channel == AddrChannel);
    bit            addr_phase_write = (write && channel == AddrChannel);
    bit            data_phase_read = (!write && channel == DataChannel);
    bit            data_phase_write = (write && channel == DataChannel);

    // if access was to a valid csr, get the csr handle
    if (csr_addr inside {cfg.ral_models[ral_name].csr_addrs}) begin
      csr = cfg.ral_models[ral_name].default_map.get_reg_by_offset(csr_addr);
      `DV_CHECK_NE_FATAL(csr, null)
    end else begin
      `uvm_fatal(`gfn, $sformatf("Access unexpected addr 0x%0h", csr_addr))
    end

    // if incoming access is a write to a valid csr, then make updates right away
    if (addr_phase_write) begin
      void'(csr.predict(.value(item.a_data), .kind(UVM_PREDICT_WRITE), .be(item.a_mask)));
    end

    // process the csr req
    // for write, update local variable and fifo at address phase
    // for read, update predication at address phase and compare at data phase
    case (csr.get_name())
      // add individual case item for each csr
      "intr_state": begin
        do_read_check = 1'b0;
      end
      "intr_enable": begin
        // FIXME
      end
      "intr_test": begin
      end
      "pin_out_ctl","pin_allowed_ctl","pin_out_value": begin
      end
      "key_invert_ctl": begin
      end
      "com_out_ctl_0","com_out_ctl_1","com_out_ctl_2","com_out_ctl_3": begin
        if (addr_phase_write) begin
          string csr_name = csr.get_name();
          string str_idx = csr_name.getc(csr_name.len - 1);
          int idx = str_idx.atoi();
          cov_if.cg_combo_detect_actions_sample (idx,
            get_field_val(ral.com_out_ctl[idx].bat_disable, item.a_data),
            get_field_val(ral.com_out_ctl[idx].interrupt, item.a_data),
            get_field_val(ral.com_out_ctl[idx].ec_rst, item.a_data),
            get_field_val(ral.com_out_ctl[idx].rst_req, item.a_data)
          );
        end
      end
      "com_sel_ctl_0","com_sel_ctl_1","com_sel_ctl_2","com_sel_ctl_3": begin
         if (addr_phase_write) begin
           string csr_name = csr.get_name();
           string str_idx = csr_name.getc(csr_name.len - 1);
           int idx = str_idx.atoi();
           cov_if.cg_combo_detect_sel_sample (idx,
             get_field_val(ral.com_sel_ctl[idx].key0_in_sel, item.a_data),
             get_field_val(ral.com_sel_ctl[idx].key1_in_sel, item.a_data),
             get_field_val(ral.com_sel_ctl[idx].key2_in_sel, item.a_data),
             get_field_val(ral.com_sel_ctl[idx].pwrb_in_sel, item.a_data),
             get_field_val(ral.com_sel_ctl[idx].ac_present_sel, item.a_data)
           );
         end
      end
      "com_det_ctl_0","com_det_ctl_1","com_det_ctl_2","com_det_ctl_3": begin
         if (addr_phase_write) begin
           string csr_name = csr.get_name();
           string str_idx = csr_name.getc(csr_name.len - 1);
           int idx = str_idx.atoi();
           cov_if.cg_combo_detect_det_sample (idx,
             get_field_val(ral.com_det_ctl[idx].detection_timer, item.a_data)
           );
         end
      end
      "ec_rst_ctl": begin
        if (addr_phase_write) begin
          cov.debounce_timer_cg["ec_rst_ctl"].debounce_timer_cg.sample(
            get_field_val(ral.ec_rst_ctl.ec_rst_pulse, item.a_data)
          );
        end
      end
      "combo_intr_status": begin
        do_read_check = 1'b0;  //This check is done in sequence
        if (data_phase_read) begin
          cov_if.cg_combo_intr_status_sample (
            get_field_val(ral.combo_intr_status.combo0_h2l, item.d_data),
            get_field_val(ral.combo_intr_status.combo1_h2l, item.d_data),
            get_field_val(ral.combo_intr_status.combo2_h2l, item.d_data),
            get_field_val(ral.combo_intr_status.combo3_h2l, item.d_data)
          );
        end
      end
      "key_intr_status", "key_intr_ctl": begin
        do_read_check = 1'b0;
        if (data_phase_read) begin
          cov_if.cg_key_intr_status_sample (
            get_field_val(ral.key_intr_status.pwrb_h2l, item.d_data),
            get_field_val(ral.key_intr_status.key0_in_h2l, item.d_data),
            get_field_val(ral.key_intr_status.key1_in_h2l, item.d_data),
            get_field_val(ral.key_intr_status.key2_in_h2l, item.d_data),
            get_field_val(ral.key_intr_status.ac_present_h2l, item.d_data),
            get_field_val(ral.key_intr_status.ec_rst_l_h2l, item.d_data),
            get_field_val(ral.key_intr_status.flash_wp_l_h2l, item.d_data),
            get_field_val(ral.key_intr_status.pwrb_l2h, item.d_data),
            get_field_val(ral.key_intr_status.key0_in_l2h, item.d_data),
            get_field_val(ral.key_intr_status.key1_in_l2h, item.d_data),
            get_field_val(ral.key_intr_status.key2_in_l2h, item.d_data),
            get_field_val(ral.key_intr_status.ac_present_l2h, item.d_data),
            get_field_val(ral.key_intr_status.ec_rst_l_l2h, item.d_data),
            get_field_val(ral.key_intr_status.flash_wp_l_l2h, item.d_data)
          );
        end
      end
      "pin_in_value": begin
        do_read_check = 1'b0;  //This check is done in sequence
        if (data_phase_read) begin
          cov_if.cg_pin_in_value_sample (
            get_field_val(ral.pin_in_value.pwrb_in, item.d_data),
            get_field_val(ral.pin_in_value.key0_in, item.d_data),
            get_field_val(ral.pin_in_value.key1_in, item.d_data),
            get_field_val(ral.pin_in_value.key2_in, item.d_data),
            get_field_val(ral.pin_in_value.lid_open, item.d_data),
            get_field_val(ral.pin_in_value.ac_present, item.d_data),
            get_field_val(ral.pin_in_value.ec_rst_l, item.d_data),
            get_field_val(ral.pin_in_value.flash_wp_l, item.d_data)
          );
        end
      end
      "auto_block_debounce_ctl": begin
        cov_if.cg_auto_block_sample (
          get_field_val(ral.auto_block_debounce_ctl.debounce_timer, item.a_data),
          get_field_val(ral.auto_block_debounce_ctl.auto_block_enable, item.a_data)
        );
      end
      "auto_block_out_ctl": begin
        if (addr_phase_write) begin
          cov_if.cg_auto_blk_out_ctl_sample (
            get_field_val(ral.auto_block_out_ctl.key0_out_sel, item.a_data),
            get_field_val(ral.auto_block_out_ctl.key1_out_sel, item.a_data),
            get_field_val(ral.auto_block_out_ctl.key2_out_sel, item.a_data),
            get_field_val(ral.auto_block_out_ctl.key0_out_value, item.a_data),
            get_field_val(ral.auto_block_out_ctl.key1_out_value, item.a_data),
            get_field_val(ral.auto_block_out_ctl.key2_out_value, item.a_data)
          );
        end
      end
      "wkup_status": begin
        do_read_check = 1'b0;  //This check is done in sequence
        if (data_phase_read) begin
          cov_if.cg_wkup_status_sample (
            get_field_val(ral.wkup_status.wakeup_sts, item.d_data)
          );
        end
      end
      "ulp_ctl": begin
      end
      "ulp_ac_debounce_ctl": begin
        if (addr_phase_write) begin
          cov.debounce_timer_cg["ulp_ac_debounce_ctl"].debounce_timer_cg.sample(
            get_field_val(ral.ulp_ac_debounce_ctl.ulp_ac_debounce_timer, item.a_data)
          );
        end
      end
      "ulp_lid_debounce_ctl": begin
        if (addr_phase_write) begin
          cov.debounce_timer_cg["ulp_lid_debounce_ctl"].debounce_timer_cg.sample(
            get_field_val(ral.ulp_lid_debounce_ctl.ulp_lid_debounce_timer, item.a_data)
          );
        end
      end
      "ulp_pwrb_debounce_ctl": begin
        if (addr_phase_write) begin
          cov.debounce_timer_cg["ulp_pwrb_debounce_ctl"].debounce_timer_cg.sample(
            get_field_val(ral.ulp_pwrb_debounce_ctl.ulp_pwrb_debounce_timer, item.a_data)
          );
        end
      end
      "key_intr_debounce_ctl": begin
        if (addr_phase_write) begin
          cov.debounce_timer_cg["key_intr_debounce_ctl"].debounce_timer_cg.sample(
            get_field_val(ral.key_intr_debounce_ctl.debounce_timer, item.a_data)
          );
        end
      end
      "ulp_status": begin
        do_read_check = 1'b0; // This check is done in sequence
        if (data_phase_read) begin
          cov_if.cg_ulp_status_sample (
            get_field_val(ral.ulp_status.ulp_wakeup, item.d_data)
          );
        end
      end
      "regwen":begin
      end
      default: begin
       `uvm_error(`gfn, $sformatf("invalid csr: %0s", csr.get_full_name()))
      end
    endcase

    // On reads, if do_read_check, is set, then check mirrored_value against item.d_data
    if (data_phase_read) begin
      if (do_read_check) begin
        `DV_CHECK_EQ(csr.get_mirrored_value(), item.d_data, $sformatf(
                     "reg name: %0s", csr.get_full_name()))
      end
      void'(csr.predict(.value(item.d_data), .kind(UVM_PREDICT_READ)));
    end
  endtask

  virtual function void reset(string kind = "HARD");
    super.reset(kind);
    // reset local fifos queues and variables
    intr_exp    = ral.intr_state.get_reset();
  endfunction

  function void check_phase(uvm_phase phase);
    super.check_phase(phase);
    // post test checks - ensure that all local fifos and queues are empty
  endfunction

endclass
