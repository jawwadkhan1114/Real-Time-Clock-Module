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

entity rtc_parallel_load_one_sec is
port(
rst_n : in std_logic; -- active low synchronous reset
clk : in std_logic; -- system clock
clr_n : in std_logic; -- active low synchronous clear
address : in std_logic_vector(3 downto 0);
data : in std_logic_vector(6 downto 0);
wr_n : in std_logic; -- write control strobe, active low
cs_n : in std_logic; -- chip select strobe, active low
f32768hz : in std_logic; -- 32.768 kHz oscillator input
max_count : out std_logic;-- max count
one_hz : out std_logic; -- one Hz output square wave
count_sec : out std_logic_vector(6 downto 0); -- BCD sec count
count_min : out std_logic_vector(6 downto 0); -- BCD min count
count_hour : out std_logic_vector(5 downto 0) -- BCD hour count
);
attribute loc: string; 
	attribute loc of f32768hz: signal is "D3";
	attribute loc of rst_n: signal is "F1";
	attribute loc of clk: signal is "J1";
	attribute loc of clr_n: signal is "C2";
	attribute loc of cs_n: signal is "E10";
	attribute loc of wr_n: signal is "B4";

	attribute loc of data: signal is "A13,F8,C12,F9,E8,E7,D7";
	attribute loc of address: signal is "C5,E6,A10,D9";

	attribute loc of one_hz: signal is "B5";
	attribute loc of max_count: signal is "D6";
	attribute loc of count_sec: signal is "A3,A4,A5,B7,B9,F7,C4";
	attribute loc of count_min: signal is "B1, E3, F5,F2,E2,D2,C1";
	attribute loc of count_hour: signal is "H2,G2,L3,K4,K1,J3";

end rtc_parallel_load_one_sec;



--}} End of automatically maintained section

architecture structural of rtc_parallel_load_one_sec is		
signal address_bus : std_logic_vector(9 downto 0); 
signal flip_flop_out : std_logic; 
signal wr_n_pos_edge : std_logic;  
signal cnt_en_1sec : std_logic;
begin
	u0: entity pos_edge_detector port map(
		a => wr_n,
		rst_n => rst_n,
		clk => clk,
		a_pe => wr_n_pos_edge
	);
	u1: entity write_address_decoder port map(
		wr => wr_n_pos_edge,
		cs_n => cs_n,
		address => address,
		y => address_bus
	);
	u2: entity s_r_flip_flop port map(
		s => address_bus(4),
		r => address_bus(0),
		clk => clk,	
		rst_n => rst_n,
		q => flip_flop_out
	);
	u3: entity one_sec_counter port map(
		f32768hz => f32768hz,
		clk => clk, 
		rst_n => rst_n,
		clr_n => clr_n,
		one_sec_tick => cnt_en_1sec,
		one_hz => one_hz
	);
	u4: entity clock_chain port map(
		rst_n => rst_n,
		clk => clk,
		clr_n => clr_n,
		load_sec_en => address_bus(1),
		load_min_en => address_bus(2),
		load_hour_en => address_bus(3),
		setting_sec => data(6 downto 0), 
		setting_min => data(6 downto 0),
		setting_hour => data(5 downto 0),
		cnt_en_1 => cnt_en_1sec,
		cnt_en_2 => flip_flop_out,
		max_count =>  max_count,
		count_sec => count_sec,
		count_min => count_min,
		count_hour => count_hour
	);
end structural;
