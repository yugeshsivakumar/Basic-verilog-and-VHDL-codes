-- design

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity EvenParity is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           C : in STD_LOGIC;
           out : out STD_LOGIC);
end EvenParity;

architecture Behavioral of EvenParity is
begin
    process(A, B, C)
    begin
        out <= A xor B xor C;
    end process;
end Behavioral;

-- testbench

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity EvenParity_tb is
end EvenParity_tb;

architecture Behavioral of EvenParity_tb is
    signal A_tb, B_tb, C_tb : STD_LOGIC;
    signal out_tb : STD_LOGIC;

    -- Instantiate the EvenParity
    component EvenParity
        Port ( A : in STD_LOGIC;
               B : in STD_LOGIC;
               C : in STD_LOGIC;
               out : out STD_LOGIC);
    end component;

begin
    -- DUT instantiation
    DUT: EvenParity port map(
        A => A_tb,
        B => B_tb,
        C => C_tb,
        out => out_tb
    );

    -- Test process
    process
        variable i : integer;
    begin
        -- Loop through all combinations of A, B, C (0 to 7)
        for i in 0 to 7 loop
            A_tb <= std_logic(to_bit((i / 4) mod 2));  -- Extract A from i
            B_tb <= std_logic(to_bit((i / 2) mod 2));  -- Extract B from i
            C_tb <= std_logic(to_bit(i mod 2));        -- Extract C from i
            wait for 10 ns;
        end loop;

        wait;
    end process;

    -- Monitor process to display the output
    process
    begin
        wait for 1 ns;
        while true loop
            report "A=" & std_logic'image(A_tb) &
                   " B=" & std_logic'image(B_tb) &
                   " C=" & std_logic'image(C_tb) &
                   " out=" & std_logic'image(out_tb);
            wait for 10 ns;
        end loop;
    end process;
end Behavioral;

