-- design

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Odd_Parity is
    Port (
        A   : in  STD_LOGIC;  -- Input A
        B   : in  STD_LOGIC;  -- Input B
        C   : in  STD_LOGIC;  -- Input C
        out : out STD_LOGIC    -- Output
    );
end Odd_Parity;

architecture Behavioral of Odd_Parity is
begin
    process(A, B, C)
    begin
        out <= not (A xor B xor C); -- Odd parity calculation
    end process;
end Behavioral;


-- testbench

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Odd_Parity_tb is
end Odd_Parity_tb;

architecture Behavioral of Odd_Parity_tb is
    signal A : STD_LOGIC;
    signal B : STD_LOGIC;
    signal C : STD_LOGIC;
    signal out : STD_LOGIC;

    -- Component Declaration for the Unit Under Test (UUT)
    component Odd_Parity
        Port (
            A   : in  STD_LOGIC;
            B   : in  STD_LOGIC;
            C   : in  STD_LOGIC;
            out : out STD_LOGIC
        );
    end component;

begin
    -- Instantiate the UUT
    DUT: Odd_Parity port map(A => A, B => B, C => C, out => out);

    -- Stimulus process
    process
    begin
        for i in 0 to 7 loop
            A <= std_logic'val((i / 4) mod 2); -- A = i[2]
            B <= std_logic'val((i / 2) mod 2); -- B = i[1]
            C <= std_logic'val(i mod 2);       -- C = i[0]
            wait for 10 ns;                    -- Wait for 10 ns
        end loop;

        wait; -- Wait indefinitely
    end process;

    -- Monitor process
    process
    begin
        wait for 10 ns; -- Wait for the first change
        while true loop
            report "A=" & std_logic'image(A) & " B=" & std_logic'image(B) & " C=" & std_logic'image(C) & " out=" & std_logic'image(out);
            wait for 10 ns; -- Wait for next change
        end loop;
    end process;

end Behavioral;