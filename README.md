# UART_TX
# What is UART

 UART stands for Universal Asynchronous Receiver/Transmitter.

 UART is a block of circuitry responsible for implementing serial communication between 2 devices.

 UART can be simplex (only transmit or recieve the data),half duplex (data transmission in both directions but not simultaneously) or Full Duplex protocol ( data transmission in both directions simultaneously).

 Data is transmitted as frames.

 It's important for lower-speed and low-throughput applications.

# inputs:-
> 8-bit parallel data which is coming from master and it will enter to UART TX to convert it to serial form and transmit them to UART RX.

> Data_valid to tell the UART that there is parallel data coming from the master.

> par_en to enable the parity flag if it's required.

> par_type to determine which parity type (even or odd) will be used in the frame.

> clk.

> rst (asynchronous reset).

# outputs :-

> TX_OUT to exit the converted data serially to be used in UART RX.

> busy it's high whenever there is a transmission. 

# Specifications: -

 UART TX receive the new data on P_DATA Bus only when Data_Valid Signal is high.

 Registers are cleared using asynchronous active low reset.

 Data_Valid is high for only 1 clock cycle.

 Busy signal is high as long as UART_TX is transmitting the frame, otherwise low.

 UART_TX couldn't accept any data on P_DATA during UART_TX processing, however Data_Valid get high.

 S_DATA is high in the IDLE case (No transmission).

 PAR_EN (Configuration)


0: To disable frame parity bit.
1: To enable frame parity bit.

 PAR_TYP (Configuration)

0: Even parity bit.
1: Odd parity bit.


