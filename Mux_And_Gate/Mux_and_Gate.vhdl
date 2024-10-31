-- design

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_and_gate is
    Port (
        A : in  STD_LOGIC;          -- Input A
        B : in  STD_LOGIC;          -- Input B
        y : out STD_LOGIC           -- Output y
    );
end mux_and_gate;

architecture Behavioral of mux_and_gate is
begin
    -- Output y is B if A is 1, otherwise 0
    y <= B when (A = '1') else '0';
end Behavioral;


-- testbench

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux_and_Gate_tb is
end Mux_and_Gate_tb;

architecture Behavioral of Mux_and_Gate_tb is
    signal a : STD_LOGIC;
    signal b : STD_LOGIC;
    signal y : STD_LOGIC;

    -- Component Declaration for the Unit Under Test (UUT)
    component mux_and_gate
        Port (
            A : in  STD_LOGIC;
            B : in  STD_LOGIC;
            y : out STD_LOGIC
        );
    end component;

begin
    -- Instantiate the UUT
    DUT: mux_and_gate port map (A => a, B => b, y => y);

    -- Test process
    process
    begin
        for integer i := 0 to 3 loop
            {a, b} <= std_logic_vector(to_unsigned(i, 2));
            wait for 10 ns; -- Wait for 10 ns after each input change
        end loop;
        
        -- Commented out test cases as in the original
        /*
        a <= '0'; b <= '0'; wait for 100 ns;
        a <= '1'; b <= '0'; wait for 100 ns;
        a <= '0'; b <= '1'; wait for 100 ns;
        a <= '1'; b <= '1'; wait for 100 ns;
        */
        
        wait; -- Wait indefinitely
    end process;

    -- Monitoring process
    process
    begin
        wait for 10 ns; -- Initial wait
        while true loop
            report "a=" & std_logic'image(a) & 
                   " b=" & std_logic'image(b) & 
                   " y=" & std_logic'image(y);
            wait for 10 ns; -- Check outputs every 10 ns
        end loop;
    end process;

end Behavioral;
