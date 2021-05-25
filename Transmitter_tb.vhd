LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY Transmitter_tb IS
END Transmitter_tb;
 
ARCHITECTURE behavior OF Transmitter_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Transmitter
    PORT(
         clock : IN  std_logic;
         load : IN  std_logic;
         send_byte : IN  std_logic_vector(9 downto 0);
         busy : OUT  std_logic;
         tx : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clock : std_logic := '0';
   signal load : std_logic := '0';
   signal send_byte : std_logic_vector(9 downto 0) := (others => '0');

 	--Outputs
   signal busy : std_logic;
   signal tx : std_logic;

   -- Clock period definitions
   constant clock_period : time := 50 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Transmitter PORT MAP (
          clock => clock,
          load => load,
          send_byte => send_byte,
          busy => busy,
          tx => tx
        );

   -- Clock process definitions
   clock_process :process
   begin
		clock <= '0';
		wait for clock_period/2;
		clock <= '1';
		wait for clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		load <= '1';
		send_byte <= "0111001101";

      wait;
   end process;

END;
