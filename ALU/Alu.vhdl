-- design 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Alu is
    Port ( a : in STD_LOGIC_VECTOR (3 downto 0);
           b : in STD_LOGIC_VECTOR (3 downto 0);
           s : in STD_LOGIC_VECTOR (3 downto 0);
           y : out STD_LOGIC_VECTOR (3 downto 0));
end Alu;

architecture Behavioral of Alu is
begin
    process(a, b, s)
    begin
        case s is
            when "0000" => y <= a + b;                      -- Addition
            when "0001" => y <= a - b;                      -- Subtraction
            when "0010" => y <= a * b;                      -- Multiplication
            when "0011" => y <= a / b;                      -- Division
            when "0100" => y <= a mod b;                    -- Modulo
            when "0101" => y <= not a;                      -- NOT a
            when "0110" => y <= not b;                      -- NOT b
            when "0111" => y <= a xor b;                    -- XOR
            when "1000" => y <= not (a or b);               -- NOR
            when "1001" => y <= not (a xor b);              -- XNOR
            when "1010" => y <= a ** b;                     -- Exponentiation
            when "1011" => y <= a and b;                    -- AND
            when "1100" => y <= a or b;                     -- OR
            when "1101" => y <= a + "0001";                 -- Increment
            when "1110" => y <= a - "0001";                 -- Decrement
            when "1111" => y <= not (a and b);              -- NAND
            when others => y <= "ZZZZ";                     -- Default case (high impedance)
        end case;
    end process;
end Behavioral;

-- testbench

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Alu_tb is
end Alu_tb;

architecture Behavioral of Alu_tb is
    signal a, b, s : STD_LOGIC_VECTOR (3 downto 0);
    signal y : STD_LOGIC_VECTOR (3 downto 0);
begin
    DUT: entity work.Alu port map(a => a, b => b, s => s, y => y);

    process
        variable i : integer := 0;
    begin
        a <= "1100";   -- 12 in binary
        b <= "0010";   -- 2 in binary
        
        for i in 0 to 15 loop
            s <= std_logic_vector(to_unsigned(i, 4));
            wait for 10 ns;
        end loop;
        
        wait;
    end process;

    process
    begin
        wait for 1 ns;
        while true loop
            report "S=" & integer'image(to_integer(unsigned(s))) & 
                   " A=" & integer'image(to_integer(unsigned(a))) & 
                   " B=" & integer'image(to_integer(unsigned(b))) & 
                   " Output=" & integer'image(to_integer(unsigned(y)));
            wait for 10 ns;
        end loop;
    end process;
end Behavioral;
