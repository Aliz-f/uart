library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity uart_component is
	port (
		clk : in std_logic;
		uart_data_input : in std_logic_vector (9 downto 0);
		uart_data_output : out std_logic_vector (9 downto 0):= "0000000000"
	);
end uart_component;

architecture uart_component_arch of uart_component is
    
component Receiver is
        port( clock : in std_logic;
              rx : in std_logic;
              recv_byte : out std_logic_vector( 9 downto 0 );
              ready : out std_logic );
end component;


Component Transmitter is
    port( clock : in std_logic;
          load : in std_logic;
          send_byte : in std_logic_vector( 9 downto 0 );
          busy : out std_logic;
          tx : out std_logic );
end component;

for R : Receiver use entity work.Receiver(Receiver_arch);
for T : Transmitter use entity work.Transmitter(Transmitter_arch);

signal busy_temp, tx_temp, ready_temp : std_logic;
begin

T : Transmitter port map (clk, '1', uart_data_input, busy_temp, tx_temp );
R : Receiver port map (clk, tx_temp, uart_data_output, ready_temp );

end uart_component_arch;

