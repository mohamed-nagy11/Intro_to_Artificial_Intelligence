

# Define the simple-reflex agent function
def simple_reflex_agent(percepts):
    location = percepts["location"]

    if percepts["status_" + location] == "Dirty":
        return "Suck"
    else:
        return "Left" if location == "A" else "Right"

# Function to run the agent until the goal is reached
def run_agent_interactively():
    location = input("Enter the initial location of the cleaner (A or B): ")
    status_A = input("Enter the status of location A (Clean or Dirty): ")
    status_B = input("Enter the status of location B (Clean or Dirty): ")

    initial_state = {
        "location": location,
        "status_A": status_A,
        "status_B": status_B
    }

    state = initial_state
    performance = 0

    while True:
        percepts = {
            "location": state["location"],
            "status_" + state["location"]: state["status_" + state["location"]],
            "status_" + other_location(state["location"]): state["status_" + other_location(state["location"])]
        }

        action = simple_reflex_agent(percepts)
        if action == "Left":
            state["location"] = "A" if state["location"] == "B" else "B"
        elif action == "Right":
            state["location"] = "B" if state["location"] == "A" else "A"
        elif action == "Suck":
            state["status_" + state["location"]] = "Clean"
        performance -= 1  # Penalty for each action

        if state["status_A"] == "Clean" and state["status_B"] == "Clean":
            break

    return performance

# To get the other location
def other_location(location):
    return "A" if location == "B" else "B"

# Run the agent and display the performance
performance = run_agent_interactively()
print(f"Performance: {performance}")


