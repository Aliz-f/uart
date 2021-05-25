LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY uart_component_tb IS
END uart_component_tb;
 
ARCHITECTURE behavior OF uart_component_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT uart_component
    PORT(
         clk : IN  std_logic;
         uart_data_input : IN  std_logic_vector(9 downto 0);
         uart_data_output : OUT  std_logic_vector(9 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal uart_data_input : std_logic_vector(9 downto 0) := (others => '0');

 	--Outputs
   signal uart_data_output : std_logic_vector(9 downto 0);

   -- Clock period definitions
   constant clk_period : time := 50 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: uart_component PORT MAP (
          clk => clk,
          uart_data_input => uart_data_input,
          uart_data_output => uart_data_output
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		uart_data_input <= "0111001101";

      wait;
   end process;

END;
