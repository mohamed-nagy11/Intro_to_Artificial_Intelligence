# Define the 8 possible initial states
initial_states = [
    {"location": "A", "status_A": "Dirty", "status_B": "Dirty"},
    {"location": "A", "status_A": "Clean", "status_B": "Dirty"},
    {"location": "A", "status_A": "Dirty", "status_B": "Clean"},
    {"location": "A", "status_A": "Clean", "status_B": "Clean"},
    {"location": "B", "status_A": "Dirty", "status_B": "Dirty"},
    {"location": "B", "status_A": "Clean", "status_B": "Dirty"},
    {"location": "B", "status_A": "Dirty", "status_B": "Clean"},
    {"location": "B", "status_A": "Clean", "status_B": "Clean"},
]

# Simple reflex agent function
def simple_reflex_agent(percepts):
    location = percepts["location"]

    if percepts["status_" + location] == "Dirty":
        return "Suck"  # Suck the dirt if it's dirty
    else:
        # Alternate between "Left" and "Right" actions
        return "Left" if location == "Right" else "Right"


# Test the agent for each initial state
for initial_state in initial_states:
    state = initial_state.copy()
    performance = 0

    while True:
        action = simple_reflex_agent(state)
        if action == "Suck":
            state["status_" + state["location"]] = "Clean"
            performance -= 1  # Penalize each "Suck" action
        else:
            state["location"] = "A" if state["location"] == "B" else "B"  # Move to the other location
            performance -= 1  # Penalize each movement
        if state["status_A"] == "Clean" and state["status_B"] == "Clean":
            break

    print(f"Initial State: {initial_state}, Performance: {performance}")
