--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:58:17 05/16/2021
-- Design Name:   
-- Module Name:   C:/Users/fad12/Desktop/Vhdl/uart/receiver_tb.vhd
-- Project Name:  uart
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Receiver
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY receiver_tb IS
END receiver_tb;
 
ARCHITECTURE behavior OF receiver_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Receiver
    PORT(
         clock : IN  std_logic;
         rx : IN  std_logic;
         recv_byte : OUT  std_logic_vector(9 downto 0);
         ready : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clock : std_logic := '0';
   signal rx : std_logic := '0';

 	--Outputs
   signal recv_byte : std_logic_vector(9 downto 0);
   signal ready : std_logic;

   -- Clock period definitions
   constant clock_period : time := 50 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Receiver PORT MAP (
          clock => clock,
          rx => rx,
          recv_byte => recv_byte,
          ready => ready
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
      -- insert stimulus here 
		rx <= '0';
		wait for 50 ns;	
		rx <= '1';
		wait for 50 ns;	
		rx <= '1';
		wait for 50 ns;	
		rx <= '1';
		wait for 50 ns;	
		rx <= '0';
		wait for 50 ns;	
		rx <= '0';
		wait for 50 ns;	
		rx <= '1';
		wait for 50 ns;	
		rx <= '1';
		wait for 50 ns;	
		rx <= '0';
		wait for 50 ns;	
		rx <= '1';
		--wait for 100 ns;	

      wait;
   end process;

END;
