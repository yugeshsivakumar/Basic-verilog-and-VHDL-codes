-- design

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Binarytogray is
    Port ( b : in  STD_LOGIC_VECTOR (3 downto 0);
           g : out STD_LOGIC_VECTOR (3 downto 0));
end Binarytogray;

architecture Behavioral of Binarytogray is
begin
    g(3) <= b(3);
    g(2) <= b(3) xor b(2);
    g(1) <= b(2) xor b(1);
    g(0) <= b(1) xor b(0);
end Behavioral;

-- testbench

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Binarytogray_tb is
end Binarytogray_tb;

architecture Behavioral of Binarytogray_tb is
    signal b : STD_LOGIC_VECTOR (3 downto 0);
    signal g : STD_LOGIC_VECTOR (3 downto 0);
begin
    -- Instantiate the Binarytogray design
    DUT: entity work.Binarytogray port map (b => b, g => g);

    -- Test process
    process
        variable i : integer := 0;
    begin
        for i in 0 to 15 loop
            b <= std_logic_vector(to_unsigned(i, 4));
            wait for 10 ns;
        end loop;
        wait;
    end process;

    -- Monitor the output
    process
    begin
        wait for 1 ns;
        while true loop
            report "Binary=" & integer'image(to_integer(unsigned(b))) & 
                   " Gray=" & integer'image(to_integer(unsigned(g)));
            wait for 10 ns;
        end loop;
    end process;
end Behavioral;
