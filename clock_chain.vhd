-------------------------------------------------------------------------------
--
-- Title       : seconds_counter
-- Design      : lab10
-- Author      : JawwadKhan
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\jawwa\school stuff\spring2021\ese382\lab10\lab10\lab10\src\seconds_counter.vhd
-- Generated   : Thu Apr 22 00:42:29 2021
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
--{entity {seconds_counter} architecture {seconds_counter_arch}}

library IEEE;
use IEEE.std_logic_1164.all;
use work.all;

entity clock_chain is
port(
rst_n : in std_logic; -- active low synchronous reset
clk : in std_logic; -- system clock
clr_n : in std_logic; -- active low synchronous clear
load_sec_en : in std_logic; -- parallel load active high
load_min_en : in std_logic; -- parallel load active high
load_hour_en : in std_logic; -- parallel load active high
setting_sec : in std_logic_vector(6 downto 0); -- load value
setting_min : in std_logic_vector(6 downto 0); -- load value
setting_hour : in std_logic_vector(5 downto 0); -- load value
cnt_en_1 : in std_logic; -- enable count 1
cnt_en_2 : in std_logic; -- enable count 2
max_count : out std_logic; -- maximum count flag
count_sec : out std_logic_vector(6 downto 0); -- BCD count
count_min : out std_logic_vector(6 downto 0); -- BCD count
count_hour : out std_logic_vector(5 downto 0) -- BCD count
);
end clock_chain;



--}} End of automatically maintained section

architecture structural of clock_chain is		
signal max_count_seconds : std_logic; 
signal max_count_minutes : std_logic;  
signal count_en_minutes : std_logic;
signal count_en_hours : std_logic;
begin
	--seconds
	u1: entity modulo_60_counter port map(
		clk => clk,
		rst_n => rst_n,
		clr_n => clr_n,	
		load_en => load_sec_en,
		setting => setting_sec,
		cnt_en_1 => cnt_en_1, 
		cnt_en_2 => cnt_en_2,
		max_count => max_count_seconds,
		count => count_sec
		); 
	--minutes
	count_en_minutes <= max_count_seconds and cnt_en_1;
	u2: entity modulo_60_counter port map(
		clk => clk,
		rst_n => rst_n,
		clr_n => clr_n,	
		load_en => load_min_en,
		setting => setting_min,
		cnt_en_1 => count_en_minutes, 
		cnt_en_2 => cnt_en_2,
		max_count => max_count_minutes,
		count => count_min
		); 
	count_en_hours <= max_count_minutes and max_count_seconds and cnt_en_1;
	--hours
	u3: entity modulo_24_counter port map(
		clk => clk,
		rst_n => rst_n,
		clr_n => clr_n,	
		load_en => load_hour_en,
		setting => setting_hour,
		cnt_en_1 => count_en_hours, 
		cnt_en_2 => cnt_en_2,
		max_count => max_count,
		count => count_hour
		);	
end structural;