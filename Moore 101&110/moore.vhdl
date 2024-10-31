-- design

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity moore is
    Port (
        Data_in   : in  STD_LOGIC;
        clk       : in  STD_LOGIC;
        rst       : in  STD_LOGIC;
        Data_out  : out STD_LOGIC
    );
end moore;

architecture Behavioral of moore is
    type state_type is (Idle, s1, s11, s110, s10, s101);
    signal current_state, next_state : state_type;
begin

    -- State transition process
    process(clk, rst)
    begin
        if rst = '1' then
            current_state <= Idle;
        elsif rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process;

    -- Next state logic
    process(Data_in, current_state)
    begin
        case current_state is
            when Idle =>
                if Data_in = '0' then
                    next_state <= Idle;
                else
                    next_state <= s1;
                end if;
            when s1 =>
                if Data_in = '1' then
                    next_state <= s11;
                else
                    next_state <= s10;
                end if;
            when s11 =>
                if Data_in = '0' then
                    next_state <= s110;
                else
                    next_state <= s11;
                end if;
            when s110 =>
                if Data_in = '1' then
                    next_state <= s101;
                else
                    next_state <= Idle;
                end if;
            when s10 =>
                if Data_in = '1' then
                    next_state <= s101;
                else
                    next_state <= Idle;
                end if;
            when s101 =>
                if Data_in = '1' then
                    next_state <= s11;
                else
                    next_state <= s10;
                end if;
            when others =>
                next_state <= Idle;
        end case;
    end process;

    -- Output logic
    Data_out <= '1' when (current_state = s101 or current_state = s110) else '0';

end Behavioral;

-- testbench

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity moore_tb is
end moore_tb;

architecture Behavioral of moore_tb is
    signal Data_in_tb  : STD_LOGIC := '0';
    signal clk_tb      : STD_LOGIC := '0';
    signal rst_tb      : STD_LOGIC;
    signal Data_out_tb : STD_LOGIC;

    -- Component Declaration for the Unit Under Test (UUT)
    component moore
        Port (
            Data_in   : in  STD_LOGIC;
            clk       : in  STD_LOGIC;
            rst       : in  STD_LOGIC;
            Data_out  : out STD_LOGIC
        );
    end component;

begin
    -- Instantiate the UUT
    DUT: moore port map(Data_in => Data_in_tb, clk => clk_tb, rst => rst_tb, Data_out => Data_out_tb);

    -- Clock generation
    clk_process : process
    begin
        while true loop
            clk_tb <= '1';
            wait for 10 ns;
            clk_tb <= '0';
            wait for 10 ns;
        end loop;
    end process;

    -- Stimulus process
    process
    begin
        -- Initialize signals
        Data_in_tb <= '0';
        rst_tb <= '0';

        -- Apply reset
        rst_tb <= '1';
        wait for 20 ns;
        rst_tb <= '0';

        -- Apply input sequence
        wait for 20 ns;
        Data_in_tb <= '1';  -- Move to state s1
        wait for 20 ns;
        Data_in_tb <= '0';  -- Move to state s10
        wait for 20 ns;
        Data_in_tb <= '1';  -- Move to state s101
        wait for 20 ns;

        -- Apply reset again
        rst_tb <= '1';
        wait for 20 ns;
        rst_tb <= '0';

        -- Continue input sequence
        wait for 20 ns;
        Data_in_tb <= '1';  -- Move to state s1
        wait for 20 ns;
        Data_in_tb <= '1';  -- Move to state s11
        wait for 20 ns;
        Data_in_tb <= '0';  -- Move to state s110

        wait;  -- Wait indefinitely
    end process;

end Behavioral;