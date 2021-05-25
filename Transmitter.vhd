library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Transmitter is
    port( clock : in std_logic;
          load : in std_logic;
          send_byte : in std_logic_vector( 9 downto 0 );
          busy : out std_logic;
          tx : out std_logic );
			 
end Transmitter;

architecture Transmitter_arch of Transmitter is

signal sending_byte : std_logic_vector( 9 downto 0 );

begin

send_process : process ( clock, load )
type MyState is ( START, DATA, STOP );
variable state : MyState := START;
variable count : integer range 0 to 9 := 0;

begin
    if clock'event AND clock = '1' then
        case state is
            when START =>
                if load = '1' then
                    sending_byte <= send_byte;
                    tx <= '0'; -- start bit = 0 
                    busy <= '1';
                    count := 0;
                    state := DATA;
                else
                    busy <= '0';
                    tx <= '1';
                end if;
            when DATA =>
                --busy<='1';
                case count is
                    when 0 =>
                        tx <= sending_byte( 9 );
                    when 1 =>
                        tx <= sending_byte( 8 );
                    when 2 =>
                        tx <= sending_byte( 7 );
                    when 3 =>
                        tx <= sending_byte( 6 );
                    when 4 =>
                        tx <= sending_byte( 5 );
                    when 5 =>
                        tx <= sending_byte( 4 );
                    when 6 =>
                        tx <= sending_byte( 3 );
                    when 7 =>
                        tx <= sending_byte( 2 );
                    when 8 =>
                        tx <= sending_byte( 1 );								
                    when 9 =>
                        tx <= sending_byte( 0 );
                        state := STOP;
                    when others =>
                        state := STOP;
                end case;
                count := count + 1;
            when STOP =>
                busy <= '0';
                tx <= '1';
                state := START;
            when others =>
                busy<='0';
                state := START;
         end case;
    end if;
end process;


end Transmitter_arch;

