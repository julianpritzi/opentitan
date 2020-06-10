// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0
//
// Register Package auto-generated by `reggen` containing data structure

package dcd_reg_pkg;

  // Param list
  parameter int NumAdcFilter = 8;
  parameter int NumAdcChannel = 2;

  ////////////////////////////
  // Typedefs for registers //
  ////////////////////////////
  typedef struct packed {
    logic        q;
  } dcd_reg2hw_intr_state_reg_t;

  typedef struct packed {
    logic        q;
  } dcd_reg2hw_intr_enable_reg_t;

  typedef struct packed {
    logic        q;
    logic        qe;
  } dcd_reg2hw_intr_test_reg_t;

  typedef struct packed {
    logic        q;
    logic        qe;
  } dcd_reg2hw_adc_en_ctl_reg_t;

  typedef struct packed {
    struct packed {
      logic        q;
      logic        qe;
    } adc_low-power_mode;
    struct packed {
      logic [3:0]  q;
      logic        qe;
    } adc_power_up_time;
    struct packed {
      logic [23:0] q;
      logic        qe;
    } adc_deep-sleep_wakeup_timer;
  } dcd_reg2hw_adc_pd_ctl_reg_t;

  typedef struct packed {
    struct packed {
      logic [7:0]  q;
      logic        qe;
    } lp_sample_count;
    struct packed {
      logic [7:0]  q;
      logic        qe;
    } adc_latency;
  } dcd_reg2hw_adc_lp_sample_ctl_reg_t;

  typedef struct packed {
    logic [15:0] q;
    logic        qe;
  } dcd_reg2hw_adc_sample_ctl_reg_t;

  typedef struct packed {
    logic        q;
    logic        qe;
  } dcd_reg2hw_adc_fsm_rst_reg_t;

  typedef struct packed {
    struct packed {
      logic [1:0]  q;
      logic        qe;
    } min_ext;
    struct packed {
      logic [9:0] q;
      logic        qe;
    } min;
    struct packed {
      logic        q;
      logic        qe;
    } cond;
    struct packed {
      logic [1:0]  q;
      logic        qe;
    } max_ext;
    struct packed {
      logic [9:0] q;
      logic        qe;
    } max;
  } dcd_reg2hw_adc_chn0_filter_ctl_mreg_t;

  typedef struct packed {
    struct packed {
      logic [1:0]  q;
      logic        qe;
    } min_ext;
    struct packed {
      logic [9:0] q;
      logic        qe;
    } min;
    struct packed {
      logic        q;
      logic        qe;
    } cond;
    struct packed {
      logic [1:0]  q;
      logic        qe;
    } max_ext;
    struct packed {
      logic [9:0] q;
      logic        qe;
    } max;
  } dcd_reg2hw_adc_chn1_filter_ctl_mreg_t;

  typedef struct packed {
    struct packed {
      logic [1:0]  q;
      logic        qe;
    } adc_chn_value_ext;
    struct packed {
      logic [9:0] q;
      logic        qe;
    } adc_chn_value;
    struct packed {
      logic [1:0]  q;
      logic        qe;
    } adc_chn_value_int_ext;
    struct packed {
      logic [9:0] q;
      logic        qe;
    } adc_chn_value_int;
  } dcd_reg2hw_adc_chn_val_mreg_t;

  typedef struct packed {
    struct packed {
      logic        q;
      logic        qe;
    } chn0_1_filter0_en;
    struct packed {
      logic        q;
      logic        qe;
    } chn0_1_filter1_en;
    struct packed {
      logic        q;
      logic        qe;
    } chn0_1_filter2_en;
    struct packed {
      logic        q;
      logic        qe;
    } chn0_1_filter3_en;
    struct packed {
      logic        q;
      logic        qe;
    } chn0_1_filter4_en;
    struct packed {
      logic        q;
      logic        qe;
    } chn0_1_filter5_en;
    struct packed {
      logic        q;
      logic        qe;
    } chn0_1_filter6_en;
    struct packed {
      logic        q;
      logic        qe;
    } chn0_1_filter7_en;
  } dcd_reg2hw_adc_wakeup_ctl_reg_t;

  typedef struct packed {
    struct packed {
      logic        q;
      logic        qe;
    } cc_sink_det;
    struct packed {
      logic        q;
      logic        qe;
    } cc_1a5_sink_det;
    struct packed {
      logic        q;
      logic        qe;
    } cc_3a0_sink_det;
    struct packed {
      logic        q;
      logic        qe;
    } cc_src_det;
    struct packed {
      logic        q;
      logic        qe;
    } cc_1a5_src_det;
    struct packed {
      logic        q;
      logic        qe;
    } cc_src_det_flip;
    struct packed {
      logic        q;
      logic        qe;
    } cc_1a5_src_det_flip;
    struct packed {
      logic        q;
      logic        qe;
    } cc_discon;
  } dcd_reg2hw_adc_wakeup_status_reg_t;

  typedef struct packed {
    struct packed {
      logic        q;
      logic        qe;
    } chn0_1_filter0_en;
    struct packed {
      logic        q;
      logic        qe;
    } chn0_1_filter1_en;
    struct packed {
      logic        q;
      logic        qe;
    } chn0_1_filter2_en;
    struct packed {
      logic        q;
      logic        qe;
    } chn0_1_filter3_en;
    struct packed {
      logic        q;
      logic        qe;
    } chn0_1_filter4_en;
    struct packed {
      logic        q;
      logic        qe;
    } chn0_1_filter5_en;
    struct packed {
      logic        q;
      logic        qe;
    } chn0_1_filter6_en;
    struct packed {
      logic        q;
      logic        qe;
    } chn0_1_filter7_en;
  } dcd_reg2hw_adc_filter_ctl_reg_t;

  typedef struct packed {
    struct packed {
      logic        q;
      logic        qe;
    } cc_sink_det;
    struct packed {
      logic        q;
      logic        qe;
    } cc_1a5_sink_det;
    struct packed {
      logic        q;
      logic        qe;
    } cc_3a0_sink_det;
    struct packed {
      logic        q;
      logic        qe;
    } cc_src_det;
    struct packed {
      logic        q;
      logic        qe;
    } cc_1a5_src_det;
    struct packed {
      logic        q;
      logic        qe;
    } cc_src_det_flip;
    struct packed {
      logic        q;
      logic        qe;
    } cc_1a5_src_det_flip;
    struct packed {
      logic        q;
      logic        qe;
    } cc_discon;
  } dcd_reg2hw_adc_filter_status_reg_t;


  typedef struct packed {
    logic        d;
    logic        de;
  } dcd_hw2reg_intr_state_reg_t;

  typedef struct packed {
    logic        d;
    logic        de;
  } dcd_hw2reg_adc_en_ctl_reg_t;

  typedef struct packed {
    struct packed {
      logic        d;
      logic        de;
    } adc_low-power_mode;
    struct packed {
      logic [3:0]  d;
      logic        de;
    } adc_power_up_time;
    struct packed {
      logic [23:0] d;
      logic        de;
    } adc_deep-sleep_wakeup_timer;
  } dcd_hw2reg_adc_pd_ctl_reg_t;

  typedef struct packed {
    struct packed {
      logic [7:0]  d;
      logic        de;
    } lp_sample_count;
    struct packed {
      logic [7:0]  d;
      logic        de;
    } adc_latency;
  } dcd_hw2reg_adc_lp_sample_ctl_reg_t;

  typedef struct packed {
    logic [15:0] d;
    logic        de;
  } dcd_hw2reg_adc_sample_ctl_reg_t;

  typedef struct packed {
    logic        d;
    logic        de;
  } dcd_hw2reg_adc_fsm_rst_reg_t;

  typedef struct packed {
    struct packed {
      logic [1:0]  d;
      logic        de;
    } min_ext;
    struct packed {
      logic [9:0] d;
      logic        de;
    } min;
    struct packed {
      logic        d;
      logic        de;
    } cond;
    struct packed {
      logic [1:0]  d;
      logic        de;
    } max_ext;
    struct packed {
      logic [9:0] d;
      logic        de;
    } max;
  } dcd_hw2reg_adc_chn0_filter_ctl_mreg_t;

  typedef struct packed {
    struct packed {
      logic [1:0]  d;
      logic        de;
    } min_ext;
    struct packed {
      logic [9:0] d;
      logic        de;
    } min;
    struct packed {
      logic        d;
      logic        de;
    } cond;
    struct packed {
      logic [1:0]  d;
      logic        de;
    } max_ext;
    struct packed {
      logic [9:0] d;
      logic        de;
    } max;
  } dcd_hw2reg_adc_chn1_filter_ctl_mreg_t;

  typedef struct packed {
    struct packed {
      logic [1:0]  d;
      logic        de;
    } adc_chn_value_ext;
    struct packed {
      logic [9:0] d;
      logic        de;
    } adc_chn_value;
    struct packed {
      logic [1:0]  d;
      logic        de;
    } adc_chn_value_int_ext;
    struct packed {
      logic [9:0] d;
      logic        de;
    } adc_chn_value_int;
  } dcd_hw2reg_adc_chn_val_mreg_t;

  typedef struct packed {
    struct packed {
      logic        d;
      logic        de;
    } chn0_1_filter0_en;
    struct packed {
      logic        d;
      logic        de;
    } chn0_1_filter1_en;
    struct packed {
      logic        d;
      logic        de;
    } chn0_1_filter2_en;
    struct packed {
      logic        d;
      logic        de;
    } chn0_1_filter3_en;
    struct packed {
      logic        d;
      logic        de;
    } chn0_1_filter4_en;
    struct packed {
      logic        d;
      logic        de;
    } chn0_1_filter5_en;
    struct packed {
      logic        d;
      logic        de;
    } chn0_1_filter6_en;
    struct packed {
      logic        d;
      logic        de;
    } chn0_1_filter7_en;
  } dcd_hw2reg_adc_wakeup_ctl_reg_t;

  typedef struct packed {
    struct packed {
      logic        d;
      logic        de;
    } cc_sink_det;
    struct packed {
      logic        d;
      logic        de;
    } cc_1a5_sink_det;
    struct packed {
      logic        d;
      logic        de;
    } cc_3a0_sink_det;
    struct packed {
      logic        d;
      logic        de;
    } cc_src_det;
    struct packed {
      logic        d;
      logic        de;
    } cc_1a5_src_det;
    struct packed {
      logic        d;
      logic        de;
    } cc_src_det_flip;
    struct packed {
      logic        d;
      logic        de;
    } cc_1a5_src_det_flip;
    struct packed {
      logic        d;
      logic        de;
    } cc_discon;
  } dcd_hw2reg_adc_wakeup_status_reg_t;

  typedef struct packed {
    struct packed {
      logic        d;
      logic        de;
    } chn0_1_filter0_en;
    struct packed {
      logic        d;
      logic        de;
    } chn0_1_filter1_en;
    struct packed {
      logic        d;
      logic        de;
    } chn0_1_filter2_en;
    struct packed {
      logic        d;
      logic        de;
    } chn0_1_filter3_en;
    struct packed {
      logic        d;
      logic        de;
    } chn0_1_filter4_en;
    struct packed {
      logic        d;
      logic        de;
    } chn0_1_filter5_en;
    struct packed {
      logic        d;
      logic        de;
    } chn0_1_filter6_en;
    struct packed {
      logic        d;
      logic        de;
    } chn0_1_filter7_en;
  } dcd_hw2reg_adc_filter_ctl_reg_t;

  typedef struct packed {
    struct packed {
      logic        d;
      logic        de;
    } cc_sink_det;
    struct packed {
      logic        d;
      logic        de;
    } cc_1a5_sink_det;
    struct packed {
      logic        d;
      logic        de;
    } cc_3a0_sink_det;
    struct packed {
      logic        d;
      logic        de;
    } cc_src_det;
    struct packed {
      logic        d;
      logic        de;
    } cc_1a5_src_det;
    struct packed {
      logic        d;
      logic        de;
    } cc_src_det_flip;
    struct packed {
      logic        d;
      logic        de;
    } cc_1a5_src_det_flip;
    struct packed {
      logic        d;
      logic        de;
    } cc_discon;
  } dcd_hw2reg_adc_filter_status_reg_t;


  ///////////////////////////////////////
  // Register to internal design logic //
  ///////////////////////////////////////
  typedef struct packed {
    dcd_reg2hw_intr_state_reg_t intr_state; // [674:674]
    dcd_reg2hw_intr_enable_reg_t intr_enable; // [673:673]
    dcd_reg2hw_intr_test_reg_t intr_test; // [672:671]
    dcd_reg2hw_adc_en_ctl_reg_t adc_en_ctl; // [670:669]
    dcd_reg2hw_adc_pd_ctl_reg_t adc_pd_ctl; // [668:637]
    dcd_reg2hw_adc_lp_sample_ctl_reg_t adc_lp_sample_ctl; // [636:619]
    dcd_reg2hw_adc_sample_ctl_reg_t adc_sample_ctl; // [618:602]
    dcd_reg2hw_adc_fsm_rst_reg_t adc_fsm_rst; // [601:600]
    dcd_reg2hw_adc_chn0_filter_ctl_mreg_t [7:0] adc_chn0_filter_ctl; // [599:360]
    dcd_reg2hw_adc_chn1_filter_ctl_mreg_t [7:0] adc_chn1_filter_ctl; // [359:120]
    dcd_reg2hw_adc_chn_val_mreg_t [1:0] adc_chn_val; // [119:64]
    dcd_reg2hw_adc_wakeup_ctl_reg_t adc_wakeup_ctl; // [63:48]
    dcd_reg2hw_adc_wakeup_status_reg_t adc_wakeup_status; // [47:32]
    dcd_reg2hw_adc_filter_ctl_reg_t adc_filter_ctl; // [31:16]
    dcd_reg2hw_adc_filter_status_reg_t adc_filter_status; // [15:0]
  } dcd_reg2hw_t;

  ///////////////////////////////////////
  // Internal design logic to register //
  ///////////////////////////////////////
  typedef struct packed {
    dcd_hw2reg_intr_state_reg_t intr_state; // [672:672]
    dcd_hw2reg_adc_en_ctl_reg_t adc_en_ctl; // [671:670]
    dcd_hw2reg_adc_pd_ctl_reg_t adc_pd_ctl; // [669:638]
    dcd_hw2reg_adc_lp_sample_ctl_reg_t adc_lp_sample_ctl; // [637:620]
    dcd_hw2reg_adc_sample_ctl_reg_t adc_sample_ctl; // [619:603]
    dcd_hw2reg_adc_fsm_rst_reg_t adc_fsm_rst; // [602:601]
    dcd_hw2reg_adc_chn0_filter_ctl_mreg_t [7:0] adc_chn0_filter_ctl; // [600:361]
    dcd_hw2reg_adc_chn1_filter_ctl_mreg_t [7:0] adc_chn1_filter_ctl; // [360:121]
    dcd_hw2reg_adc_chn_val_mreg_t [1:0] adc_chn_val; // [120:65]
    dcd_hw2reg_adc_wakeup_ctl_reg_t adc_wakeup_ctl; // [64:49]
    dcd_hw2reg_adc_wakeup_status_reg_t adc_wakeup_status; // [48:33]
    dcd_hw2reg_adc_filter_ctl_reg_t adc_filter_ctl; // [32:17]
    dcd_hw2reg_adc_filter_status_reg_t adc_filter_status; // [16:1]
  } dcd_hw2reg_t;

  // Register Address
  parameter logic [6:0] DCD_INTR_STATE_OFFSET = 7'h 0;
  parameter logic [6:0] DCD_INTR_ENABLE_OFFSET = 7'h 4;
  parameter logic [6:0] DCD_INTR_TEST_OFFSET = 7'h 8;
  parameter logic [6:0] DCD_ADC_EN_CTL_OFFSET = 7'h c;
  parameter logic [6:0] DCD_ADC_PD_CTL_OFFSET = 7'h 10;
  parameter logic [6:0] DCD_ADC_LP_SAMPLE_CTL_OFFSET = 7'h 14;
  parameter logic [6:0] DCD_ADC_SAMPLE_CTL_OFFSET = 7'h 18;
  parameter logic [6:0] DCD_ADC_FSM_RST_OFFSET = 7'h 1c;
  parameter logic [6:0] DCD_ADC_CHN0_FILTER_CTL0_OFFSET = 7'h 20;
  parameter logic [6:0] DCD_ADC_CHN0_FILTER_CTL1_OFFSET = 7'h 24;
  parameter logic [6:0] DCD_ADC_CHN0_FILTER_CTL2_OFFSET = 7'h 28;
  parameter logic [6:0] DCD_ADC_CHN0_FILTER_CTL3_OFFSET = 7'h 2c;
  parameter logic [6:0] DCD_ADC_CHN0_FILTER_CTL4_OFFSET = 7'h 30;
  parameter logic [6:0] DCD_ADC_CHN0_FILTER_CTL5_OFFSET = 7'h 34;
  parameter logic [6:0] DCD_ADC_CHN0_FILTER_CTL6_OFFSET = 7'h 38;
  parameter logic [6:0] DCD_ADC_CHN0_FILTER_CTL7_OFFSET = 7'h 3c;
  parameter logic [6:0] DCD_ADC_CHN1_FILTER_CTL0_OFFSET = 7'h 40;
  parameter logic [6:0] DCD_ADC_CHN1_FILTER_CTL1_OFFSET = 7'h 44;
  parameter logic [6:0] DCD_ADC_CHN1_FILTER_CTL2_OFFSET = 7'h 48;
  parameter logic [6:0] DCD_ADC_CHN1_FILTER_CTL3_OFFSET = 7'h 4c;
  parameter logic [6:0] DCD_ADC_CHN1_FILTER_CTL4_OFFSET = 7'h 50;
  parameter logic [6:0] DCD_ADC_CHN1_FILTER_CTL5_OFFSET = 7'h 54;
  parameter logic [6:0] DCD_ADC_CHN1_FILTER_CTL6_OFFSET = 7'h 58;
  parameter logic [6:0] DCD_ADC_CHN1_FILTER_CTL7_OFFSET = 7'h 5c;
  parameter logic [6:0] DCD_ADC_CHN_VAL0_OFFSET = 7'h 60;
  parameter logic [6:0] DCD_ADC_CHN_VAL1_OFFSET = 7'h 64;
  parameter logic [6:0] DCD_ADC_WAKEUP_CTL_OFFSET = 7'h 68;
  parameter logic [6:0] DCD_ADC_WAKEUP_STATUS_OFFSET = 7'h 6c;
  parameter logic [6:0] DCD_ADC_FILTER_CTL_OFFSET = 7'h 70;
  parameter logic [6:0] DCD_ADC_FILTER_STATUS_OFFSET = 7'h 74;


  // Register Index
  typedef enum int {
    DCD_INTR_STATE,
    DCD_INTR_ENABLE,
    DCD_INTR_TEST,
    DCD_ADC_EN_CTL,
    DCD_ADC_PD_CTL,
    DCD_ADC_LP_SAMPLE_CTL,
    DCD_ADC_SAMPLE_CTL,
    DCD_ADC_FSM_RST,
    DCD_ADC_CHN0_FILTER_CTL0,
    DCD_ADC_CHN0_FILTER_CTL1,
    DCD_ADC_CHN0_FILTER_CTL2,
    DCD_ADC_CHN0_FILTER_CTL3,
    DCD_ADC_CHN0_FILTER_CTL4,
    DCD_ADC_CHN0_FILTER_CTL5,
    DCD_ADC_CHN0_FILTER_CTL6,
    DCD_ADC_CHN0_FILTER_CTL7,
    DCD_ADC_CHN1_FILTER_CTL0,
    DCD_ADC_CHN1_FILTER_CTL1,
    DCD_ADC_CHN1_FILTER_CTL2,
    DCD_ADC_CHN1_FILTER_CTL3,
    DCD_ADC_CHN1_FILTER_CTL4,
    DCD_ADC_CHN1_FILTER_CTL5,
    DCD_ADC_CHN1_FILTER_CTL6,
    DCD_ADC_CHN1_FILTER_CTL7,
    DCD_ADC_CHN_VAL0,
    DCD_ADC_CHN_VAL1,
    DCD_ADC_WAKEUP_CTL,
    DCD_ADC_WAKEUP_STATUS,
    DCD_ADC_FILTER_CTL,
    DCD_ADC_FILTER_STATUS
  } dcd_id_e;

  // Register width information to check illegal writes
  parameter logic [3:0] DCD_PERMIT [30] = '{
    4'b 0001, // index[ 0] DCD_INTR_STATE
    4'b 0001, // index[ 1] DCD_INTR_ENABLE
    4'b 0001, // index[ 2] DCD_INTR_TEST
    4'b 0001, // index[ 3] DCD_ADC_EN_CTL
    4'b 1111, // index[ 4] DCD_ADC_PD_CTL
    4'b 0011, // index[ 5] DCD_ADC_LP_SAMPLE_CTL
    4'b 0011, // index[ 6] DCD_ADC_SAMPLE_CTL
    4'b 0001, // index[ 7] DCD_ADC_FSM_RST
    4'b 1111, // index[ 8] DCD_ADC_CHN0_FILTER_CTL0
    4'b 1111, // index[ 9] DCD_ADC_CHN0_FILTER_CTL1
    4'b 1111, // index[10] DCD_ADC_CHN0_FILTER_CTL2
    4'b 1111, // index[11] DCD_ADC_CHN0_FILTER_CTL3
    4'b 1111, // index[12] DCD_ADC_CHN0_FILTER_CTL4
    4'b 1111, // index[13] DCD_ADC_CHN0_FILTER_CTL5
    4'b 1111, // index[14] DCD_ADC_CHN0_FILTER_CTL6
    4'b 1111, // index[15] DCD_ADC_CHN0_FILTER_CTL7
    4'b 1111, // index[16] DCD_ADC_CHN1_FILTER_CTL0
    4'b 1111, // index[17] DCD_ADC_CHN1_FILTER_CTL1
    4'b 1111, // index[18] DCD_ADC_CHN1_FILTER_CTL2
    4'b 1111, // index[19] DCD_ADC_CHN1_FILTER_CTL3
    4'b 1111, // index[20] DCD_ADC_CHN1_FILTER_CTL4
    4'b 1111, // index[21] DCD_ADC_CHN1_FILTER_CTL5
    4'b 1111, // index[22] DCD_ADC_CHN1_FILTER_CTL6
    4'b 1111, // index[23] DCD_ADC_CHN1_FILTER_CTL7
    4'b 1111, // index[24] DCD_ADC_CHN_VAL0
    4'b 1111, // index[25] DCD_ADC_CHN_VAL1
    4'b 0001, // index[26] DCD_ADC_WAKEUP_CTL
    4'b 0001, // index[27] DCD_ADC_WAKEUP_STATUS
    4'b 0001, // index[28] DCD_ADC_FILTER_CTL
    4'b 0001  // index[29] DCD_ADC_FILTER_STATUS
  };
endpackage

