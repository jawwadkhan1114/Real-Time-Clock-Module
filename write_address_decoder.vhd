-------------------------------------------------------------------------------
--
-- Title       : write_address_decoder
-- Design      : lab11
-- Author      : JawwadKhan
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\jawwa\school stuff\spring2021\ese382\lab11\lab11\lab11\src\write_address_decoder.vhd
-- Generated   : Wed Apr 28 17:31:00 2021
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
--{entity {write_address_decoder} architecture {write_address_decoder_arch}}

library IEEE;
use IEEE.std_logic_1164.all;

entity write_address_decoder is
	 port(
		wr : in std_logic; -- write enable input
		cs_n : in std_logic; -- chip select input
		address : in std_logic_vector(3 downto 0); -- address bus
		y : out std_logic_vector(9 downto 0)-- selected high
    );
end write_address_decoder;

--}} End of automatically maintained section

architecture write_address_decoder_arch of write_address_decoder is
begin
	process (cs_n, wr)
	begin
		if cs_n = '0' and wr = '1' then 
			case address is
           		when "0000" => y <= "0000000001";
           		when "0001" => y <= "0000000010";
           		when "0010" => y <= "0000000100";
           		when "0011" => y <= "0000001000";
           		when "0100" => y <= "0000010000";
           		when "0101" => y <= "0000100000";
           		when "0110" => y <= "0001000000";
				when "0111" => y <= "0010000000";
				when "1000" => y <= "0100000000";
				when "1001" => y <= "1000000000";
				when "1010" => y <= "0000000000";
				when "1011" => y <= "0000000000";
				when "1100" => y <= "0000000000";
				when "1101" => y <= "0000000000";
				when "1110" => y <= "0000000000";
				when "1111" => y <= "0000000000";
            	when others => y <= "0000000000";
        end case;
		else 
			y <= "0000000000";
		end if;
	end process;
end write_address_decoder_arch;
