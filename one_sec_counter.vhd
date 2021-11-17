-------------------------------------------------------------------------------
--
-- Title       : one_sec_counter
-- Design      : lab10
-- Author      : JawwadKhan
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\jawwa\school stuff\spring2021\ese382\lab10\lab10\lab10\src\one_sec_counter.vhd
-- Generated   : Wed Apr 21 22:47:20 2021
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
--{entity {one_sec_counter} architecture {one_sec_counter_arch}}

library IEEE;
use IEEE.std_logic_1164.all;
use work.all;

entity one_sec_counter is
port(
f32768hz : in std_logic;-- 32.768 kHz oscillator input
clk : in std_logic;-- 1 MHz clock osc input
rst_n : in std_logic;-- active low synchronous reset
clr_n : in std_logic;-- synchronout clear input
one_sec_tick : out std_logic;-- one sys clock wide pulse each sec
one_hz : out std_logic-- one Hz output square wave
);
end one_sec_counter;


--}} End of automatically maintained section

architecture one_sec_counter_arch of one_sec_counter is
signal s1 : std_logic; 
begin
	u0: entity pos_edge_detector port map(
		 a => f32768hz,
		 rst_n => rst_n,
		 clk => clk,
		 a_pe => s1
		 );
	u1: entity one_sec_prescalar port map(
		clk => clk,
		rst_n => rst_n,
		clr_n => clr_n,
		cnt_en => s1, 
		one_hz => one_hz,
		one_sec_tick => one_sec_tick
		);
end one_sec_counter_arch;
