-------------------------------------------------------------------------------
--
-- Title       : s_r_flip_flop
-- Design      : lab11
-- Author      : JawwadKhan
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\jawwa\school stuff\spring2021\ese382\lab11\lab11\lab11\src\s_r_flip_flop.vhd
-- Generated   : Wed Apr 28 18:03:19 2021
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
--{entity {s_r_flip_flop} architecture {s_r_flip_flop_arch}}

library IEEE;
use IEEE.std_logic_1164.all;

entity s_r_flip_flop is
	 port(
		 s : in STD_LOGIC;
		 r : in STD_LOGIC;
		 clk : in STD_LOGIC;
		 rst_n : in STD_LOGIC;
		 q : out STD_LOGIC
	     );
end s_r_flip_flop;

--}} End of automatically maintained section

architecture s_r_flip_flop_arch of s_r_flip_flop is	   
begin
	process (clk, rst_n)
	variable tempq : std_logic;
	begin 
		if rising_edge(clk) then
			if rst_n = '0' then
				tempq := '1';
			else 
				tempq := s or (not r and tempq);
			end if;
		end if;
	q <= tempq;
	end process;
end s_r_flip_flop_arch;
