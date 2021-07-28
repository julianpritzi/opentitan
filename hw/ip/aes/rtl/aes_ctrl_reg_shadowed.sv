// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0
//
// AES shadowed control register
//
// This module implements the AES shadowed control register. The main differences compared
// to implementing the register as part of the auto-generated aes_reg_top.sv are:
//
// 1. The hardware can block updates to the control register from software.
//    Whenever the module is busy, control register writes are ignored.
// 2. Invalid values written by software are resolved to valid configurations.

`include "prim_assert.sv"

module aes_ctrl_reg_shadowed
  import aes_pkg::*;
  import aes_reg_pkg::*;
#(
  parameter bit AES192Enable         = 1,
  parameter bit SecAllowForcingMasks = 0
) (
  input  logic clk_i,
  input  logic rst_ni,

  // Main control
  output logic      qe_o, // software wants to write
  input  logic      we_i, // hardware grants software write
  output aes_op_e   operation_o,
  output aes_mode_e mode_o,
  output key_len_e  key_len_o,
  output logic      manual_operation_o,
  output logic      force_zero_masks_o,

  // Alerts
  output logic err_update_o,
  output logic err_storage_o,

  // Bus interface
  input  aes_reg2hw_ctrl_shadowed_reg_t reg2hw_ctrl_i,
  output aes_hw2reg_ctrl_shadowed_reg_t hw2reg_ctrl_o
);

  // Signals
  ctrl_reg_t ctrl_wd;
  aes_mode_e mode;
  key_len_e  key_len;
  logic      err_update_operation;
  logic      err_update_mode;
  logic      err_update_key_len;
  logic      err_update_manual_operation;
  logic      err_update_force_zero_masks;
  logic      err_storage_operation;
  logic      err_storage_mode;
  logic      err_storage_key_len;
  logic      err_storage_manual_operation;
  logic      err_storage_force_zero_masks;

  // Unused signals
  logic unused_force_zero_masks;

  // Get and forward write enable. Writes are only allowed if the module is idle.
  assign qe_o = reg2hw_ctrl_i.operation.qe & reg2hw_ctrl_i.mode.qe &
      reg2hw_ctrl_i.key_len.qe & reg2hw_ctrl_i.manual_operation.qe &
      reg2hw_ctrl_i.force_zero_masks.qe;

  // Get and resolve values from register interface.
  assign ctrl_wd.operation = aes_op_e'(reg2hw_ctrl_i.operation.q);

  assign mode = aes_mode_e'(reg2hw_ctrl_i.mode.q);
  always_comb begin : mode_get
    unique case (mode)
      AES_ECB: ctrl_wd.mode = AES_ECB;
      AES_CBC: ctrl_wd.mode = AES_CBC;
      AES_CFB: ctrl_wd.mode = AES_CFB;
      AES_OFB: ctrl_wd.mode = AES_OFB;
      AES_CTR: ctrl_wd.mode = AES_CTR;
      default: ctrl_wd.mode = AES_NONE; // unsupported values are mapped to AES_NONE
    endcase
  end

  assign key_len = key_len_e'(reg2hw_ctrl_i.key_len.q);
  always_comb begin : key_len_get
    unique case (key_len)
      AES_128: ctrl_wd.key_len = AES_128;
      AES_256: ctrl_wd.key_len = AES_256;
      AES_192: ctrl_wd.key_len = AES192Enable ? AES_192 : AES_256;
      default: ctrl_wd.key_len = AES_256; // unsupported values are mapped to AES_256
    endcase
  end

  assign ctrl_wd.manual_operation = reg2hw_ctrl_i.manual_operation.q;

  // SecAllowForcingMasks forbids forcing the masks. Forcing the masks to zero is only
  // useful for SCA.
  assign ctrl_wd.force_zero_masks = SecAllowForcingMasks ? reg2hw_ctrl_i.force_zero_masks.q : 1'b0;
  assign unused_force_zero_masks = SecAllowForcingMasks ? 1'b0 : reg2hw_ctrl_i.force_zero_masks.q;

  // Instantiate one shadowed register primitive per field. An update error in a field should
  // only prevent the update of the affected field.
  prim_subreg_shadow #(
    .DW      ($bits(aes_op_e)),
    .SwAccess(prim_subreg_pkg::SwAccessWO),
    .RESVAL  (AES_CTRL_SHADOWED_OPERATION_RESVAL)
  ) u_ctrl_reg_shadowed_operation (
    .clk_i,
    .rst_ni,
    .re         (reg2hw_ctrl_i.operation.re),
    .we         (we_i),
    .wd         (ctrl_wd.operation),
    .de         (1'b0),
    .d          ('0),
    .qe         (),
    .q          (hw2reg_ctrl_o.operation.d),
    .qs         (),
    .err_update (err_update_operation),
    .err_storage(err_storage_operation)
  );

  prim_subreg_shadow #(
    .DW      ($bits(aes_mode_e)),
    .SwAccess(prim_subreg_pkg::SwAccessWO),
    .RESVAL  (AES_CTRL_SHADOWED_MODE_RESVAL)
  ) u_ctrl_reg_shadowed_mode (
    .clk_i,
    .rst_ni,
    .re         (reg2hw_ctrl_i.mode.re),
    .we         (we_i),
    .wd         ({ctrl_wd.mode}),
    .de         (1'b0),
    .d          ('0),
    .qe         (),
    .q          (hw2reg_ctrl_o.mode.d),
    .qs         (),
    .err_update (err_update_mode),
    .err_storage(err_storage_mode)
  );

  prim_subreg_shadow #(
    .DW      ($bits(key_len_e)),
    .SwAccess(prim_subreg_pkg::SwAccessWO),
    .RESVAL  (AES_CTRL_SHADOWED_KEY_LEN_RESVAL)
  ) u_ctrl_reg_shadowed_key_len (
    .clk_i,
    .rst_ni,
    .re         (reg2hw_ctrl_i.key_len.re),
    .we         (we_i),
    .wd         ({ctrl_wd.key_len}),
    .de         (1'b0),
    .d          ('0),
    .qe         (),
    .q          (hw2reg_ctrl_o.key_len.d),
    .qs         (),
    .err_update (err_update_key_len),
    .err_storage(err_storage_key_len)
  );

  prim_subreg_shadow #(
    .DW      (1),
    .SwAccess(prim_subreg_pkg::SwAccessWO),
    .RESVAL  (AES_CTRL_SHADOWED_MANUAL_OPERATION_RESVAL)
  ) u_ctrl_reg_shadowed_manual_operation (
    .clk_i,
    .rst_ni,
    .re         (reg2hw_ctrl_i.manual_operation.re),
    .we         (we_i),
    .wd         (ctrl_wd.manual_operation),
    .de         (1'b0),
    .d          ('0),
    .qe         (),
    .q          (hw2reg_ctrl_o.manual_operation.d),
    .qs         (),
    .err_update (err_update_manual_operation),
    .err_storage(err_storage_manual_operation)
  );

  prim_subreg_shadow #(
    .DW      (1),
    .SwAccess(prim_subreg_pkg::SwAccessWO),
    .RESVAL  (AES_CTRL_SHADOWED_FORCE_ZERO_MASKS_RESVAL)
  ) u_ctrl_reg_shadowed_force_zero_masks (
    .clk_i,
    .rst_ni,
    .re         (reg2hw_ctrl_i.force_zero_masks.re),
    .we         (we_i),
    .wd         (ctrl_wd.force_zero_masks),
    .de         (1'b0),
    .d          ('0),
    .qe         (),
    .q          (hw2reg_ctrl_o.force_zero_masks.d),
    .qs         (),
    .err_update (err_update_force_zero_masks),
    .err_storage(err_storage_force_zero_masks)
  );

  // Collect alerts.
  assign err_update_o = err_update_operation | err_update_mode | err_update_key_len |
      err_update_manual_operation | err_update_force_zero_masks;
  assign err_storage_o = err_storage_operation | err_storage_mode | err_storage_key_len |
      err_storage_manual_operation | err_storage_force_zero_masks;

  // Generate shorter references.
  // Doing that here as opposed to in aes_core avoids several Verilator lint errors.
  assign operation_o        = aes_op_e'(hw2reg_ctrl_o.operation.d);
  assign mode_o             = aes_mode_e'(hw2reg_ctrl_o.mode.d);
  assign key_len_o          = key_len_e'(hw2reg_ctrl_o.key_len.d);
  assign manual_operation_o = hw2reg_ctrl_o.manual_operation.d;
  assign force_zero_masks_o = hw2reg_ctrl_o.force_zero_masks.d;

endmodule