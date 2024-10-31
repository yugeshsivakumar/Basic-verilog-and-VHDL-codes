-- design

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Graytobinary is
    Port ( g : in STD_LOGIC_VECTOR(3 downto 0);
           b : out STD_LOGIC_VECTOR(3 downto 0));
end Graytobinary;

architecture Behavioral of Graytobinary is
begin
    b(3) <= g(3);
    b(2) <= g(3) XOR g(2);
    b(1) <= g(3) XOR g(2) XOR g(1);
    b(0) <= g(3) XOR g(2) XOR g(1) XOR g(0);
end Behavioral;


-- testbench

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Graytobinary_tb is
end Graytobinary_tb;

architecture Behavioral of Graytobinary_tb is
    signal g : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal b : STD_LOGIC_VECTOR(3 downto 0);
    
    component Graytobinary
        Port ( g : in STD_LOGIC_VECTOR(3 downto 0);
               b : out STD_LOGIC_VECTOR(3 downto 0));
    end component;
    
begin
    -- Instantiate the Gray to Binary module
    DUT: Graytobinary port map(g => g, b => b);

    -- Test process
    process
    begin
        for i in 0 to 15 loop
            g <= std_logic_vector(to_unsigned(i, 4));
            wait for 10 ns;
        end loop;
        wait;
    end process;

    -- Monitor output
    process (g, b)
    begin
        report "Time=" & integer'image(now / 1 ns) &
               " ns : Gray=" & integer'image(to_integer(unsigned(g))) &
               " Binary=" & integer'image(to_integer(unsigned(b)));
    end process;
    
end Behavioral;