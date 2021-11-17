-------------------------------------------------------------------------------
--
-- Title       : modulo_60_counter
-- Design      : lab10
-- Author      : JawwadKhan
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\jawwa\school stuff\spring2021\ese382\lab10\lab10\lab10\src\modulo_60_counter.vhd
-- Generated   : Wed Apr 21 23:00:27 2021
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {modulo_60_counter} architecture {modulo_60_counter_arch}}

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity modulo_24_counter is
port(
rst_n : in std_logic;-- active low synchronous reset
clk : in std_logic;-- system clock
clr_n : in std_logic;-- active low synchronous clear
load_en : in std_logic;-- parallel load active high
setting : in std_logic_vector(5 downto 0);-- load value
cnt_en_1 : in std_logic;-- enable count 1
cnt_en_2 : in std_logic;-- enable count 2
max_count : out std_logic;-- maximum count flag
count : out std_logic_vector(5 downto 0)-- BCD count
);	  

end modulo_24_counter;


--}} End of automatically maintained section

architecture modulo_24_counter_arch of modulo_24_counter is
begin
   process(clk,rst_n,load_en,setting,clr_n)	 
   variable tens_place_count : integer range 0 to 7;
	variable ones_place_count : integer range 0 to 15;
   begin 
	if load_en = '1' then 
		count <= setting;
		tens_place_count := to_integer(unsigned(setting(5 downto 4)));
		ones_place_count := to_integer(unsigned(setting(3 downto 0)));
		if ones_place_count = 3 and tens_place_count = 2 then  
			max_count <= '1';
		end if;
   elsif rising_edge (clk) then
	   if clr_n = '0' or rst_n = '0' then  
		   tens_place_count := 0;
		   ones_place_count := 0;
		   max_count <= '0';
		   count <= "000000"; 
	   elsif cnt_en_1 = '1' and cnt_en_2 = '1' then 
		   if ones_place_count = 3 and tens_place_count = 2 then  
			   ones_place_count := 0;
			   tens_place_count := 0;
			   max_count <= '0';
		  elsif ones_place_count = 9 then 
			  ones_place_count := 0;
			  tens_place_count := tens_place_count + 1;
		  else
			  ones_place_count := ones_place_count + 1;
			  if ones_place_count = 3 and tens_place_count = 2 then  
			  	max_count <= '1';
			  end if;
			  
		  end if;	
	   end if;
	   count <= std_logic_vector(to_unsigned(tens_place_count,2)) & std_logic_vector(to_unsigned(ones_place_count,4));
   end if;
end process; 
end modulo_24_counter_arch;
