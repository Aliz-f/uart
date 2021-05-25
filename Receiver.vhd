library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Receiver is

	 port( clock : in std_logic;
          rx : in std_logic;
          recv_byte : out std_logic_vector( 9 downto 0 );
          ready : out std_logic );

end Receiver;

architecture Receiver_arch of Receiver is

	signal parity, end_bit : std_logic;
	signal recv_byte_temp : std_logic_vector( 9 downto 0 );

begin

recv_process : process ( clock, rx )
	
	type MyState is ( START, DATA, STOP );
	variable state : MyState := START;
	variable count : integer range 0 to 11 := 0;

begin
    if clock'event AND clock = '0' then
        case state is
            when START =>
                ready <= '0';
                if rx = '0' then -- start bit = 0
                    count := 0;
                    state := DATA;
						  recv_byte_temp <= "0000000000";
                end if;
            when DATA =>
                case count is
                    when 0 =>
                        recv_byte( 9 ) <= rx;
                        count := 1;
                    when 1 =>
						      recv_byte( 8 ) <= rx;
								--parity <= rx;
                        count := 2;
						  when 2 =>
                        recv_byte( 7 ) <= rx;
                        count := 3;
                    when 3 =>
                        recv_byte( 6 ) <= rx;
                        count := 4;
                    when 4 =>
                        recv_byte( 5 ) <= rx;
                        count := 5;
                    when 5 =>
                        recv_byte( 4 ) <= rx;
                        count := 6;
                    when 6 =>
                        recv_byte( 3 ) <= rx;
                        count := 7;
                    when 7 =>
                        recv_byte( 2 ) <= rx;
                        count := 8;
                    when 8 =>
                        recv_byte( 1 ) <= rx;
								count := 9;
                    when 9 =>
						      recv_byte( 0 ) <= rx; -- end bit = 1
						      --end_bit <= rx;
								state := STOP;
						  when others =>
                        state := START;
                end case;
            when STOP =>
                ready <= end_bit;
                state := START;
         end case;
    end if;
end process;

end Receiver_arch;

