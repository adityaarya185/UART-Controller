module uart_tx_controller(
    input              clk,
    input              reset_n,
    input [7:0]        i_Tx_Byte,
    input              i_Tx_Ready,
    output reg         o_Tx_Done,
    output reg         o_Tx_Active, // Asserted for 1 clk cycle after receiving one byte of data 
    output reg         o_Tx_Data
);

  localparam UART_TX_IDLE  = 3'b000,
             UART_TX_START = 3'b001,
             UART_TX_DATA  = 3'b010,
             UART_TX_STOP  = 3'b011;
  
  reg [2:0] r_Bit_Index;
  reg [2:0] r_State;
  reg [7:0] r_Tx_Byte;

  // UART TX Logic Implementation 
  always @(posedge clk or negedge reset_n) begin
    if (~reset_n) begin
      r_State <= UART_TX_IDLE;          
      r_Bit_Index <= 0;
      o_Tx_Done <= 1'b0;
      o_Tx_Data <= 1'b1;  
      o_Tx_Active <= 1'b0;
      r_Tx_Byte <= 8'b0;
    end else begin
      case (r_State)
        UART_TX_IDLE: begin       
          r_Bit_Index <= 0;
          o_Tx_Done <= 1'b0;
          o_Tx_Data <= 1'b1;
          o_Tx_Active <= 1'b0;
          if (i_Tx_Ready == 1'b1) begin
            r_State <= UART_TX_START;
            o_Tx_Active <= 1'b1;
            r_Tx_Byte <= i_Tx_Byte; // Latch the byte to transmit
          end
        end
        
        UART_TX_START: begin
          o_Tx_Data <= 1'b0; // Start bit
          r_State <= UART_TX_DATA;    
        end          
        
        UART_TX_DATA: begin
          o_Tx_Data <= r_Tx_Byte[r_Bit_Index];      
          if (r_Bit_Index < 7) begin
            r_Bit_Index <= r_Bit_Index + 1;
          end else begin
            r_Bit_Index <= 0;
            r_State <= UART_TX_STOP;
          end
        end        
          
        UART_TX_STOP: begin
          o_Tx_Data <= 1'b1; // Stop bit
          o_Tx_Done <= 1'b1;
          r_State <= UART_TX_IDLE;
        end           
          
        default: begin
          r_State <= UART_TX_IDLE;
        end
      endcase
    end
  end
endmodule
