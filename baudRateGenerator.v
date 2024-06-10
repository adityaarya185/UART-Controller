module baudRateGenerator#(
    parameter CLOCK_RATE = 25000000,
    parameter BAUD_RATE = 115200,
    parameter RX_OVERSAMPLE = 16
)
(
    input clk,
    input reset_n,
    output reg o_Rx_ClkTick,
    output reg o_Tx_ClkTick
);

  // Calculate the TX and RX counters
  localparam TX_CNT = (CLOCK_RATE / (2 * BAUD_RATE));
  localparam RX_CNT = (CLOCK_RATE / (2 * BAUD_RATE * RX_OVERSAMPLE));
  localparam TX_CNT_WIDTH = $clog2(TX_CNT);
  localparam RX_CNT_WIDTH = $clog2(RX_CNT);

  // Declare counters
  reg [TX_CNT_WIDTH-1:0] r_Tx_Counter;
  reg [RX_CNT_WIDTH-1:0] r_Rx_Counter;

  // RX Baud Rate 
  always @(posedge clk or negedge reset_n) begin
    if (~reset_n) begin
      o_Rx_ClkTick <= 1'b0;
      r_Rx_Counter <= 0;
    end else if (r_Rx_Counter == RX_CNT - 1) begin
      o_Rx_ClkTick <= ~o_Rx_ClkTick;
      r_Rx_Counter <= 0;
    end else begin
      r_Rx_Counter <= r_Rx_Counter + 1;
    end
  end

  // TX Baud Rate
  always @(posedge clk or negedge reset_n) begin
    if (~reset_n) begin
      o_Tx_ClkTick <= 1'b0;
      r_Tx_Counter <= 0;
    end else if (r_Tx_Counter == TX_CNT - 1) begin
      o_Tx_ClkTick <= ~o_Tx_ClkTick;
      r_Tx_Counter <= 0;
    end else begin
      r_Tx_Counter <= r_Tx_Counter + 1;
    end
  end
endmodule
