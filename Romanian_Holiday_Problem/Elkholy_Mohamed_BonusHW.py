from collections import deque
import time

# City Data Structure
class City:
    def __init__(self, name, h):
        self.name = name
        self.neighbors = []  # List to store neighboring cities as structures
        self.h = h

# Global Variables
all_cities_list = []  # List of all cities
all_cities_hash = {}  # Dictionary of all cities

# Utility Function to Complete the Graph
def complete_the_graph():
    global all_cities_list, all_cities_hash
    
    # Define cities
    arad = City("Arad", 366)
    zerind = City("Zerind", 374)
    oradea = City("Oradea", 380)
    sibiu = City("Sibiu", 253)
    fagaras = City("Fagaras", 176)
    rimnicu_vilcea = City("Rimnicu_Vilcea", 193)
    timisoara = City("Timisoara", 329)
    lugoj = City("Lugoj", 244)
    mehadia = City("Mehadia", 241)
    dobreta = City("Dobreta", 242)
    craiova = City("Craiova", 160)
    pitesti = City("Pitesti", 100)
    bucharest = City("Bucharest", 0)
    giurgiu = City("Giurgiu", 77)
    urziceni = City("Urziceni", 80)
    hirsova = City("Hirsova", 151)
    eforie = City("Eforie", 161)
    vaslui = City("Vaslui", 199)
    iasi = City("Iasi", 226)
    neamt = City("Neamt", 234)

    # Adding neighbors
    arad.neighbors = [(zerind, 75), (timisoara, 118), (sibiu, 140)]
    zerind.neighbors = [(oradea, 71), (arad, 75)]
    oradea.neighbors = [(zerind, 71), (sibiu, 151)]
    sibiu.neighbors = [(rimnicu_vilcea, 80), (arad, 140), (fagaras, 99)]
    fagaras.neighbors = [(sibiu, 99), (bucharest, 211)]
    rimnicu_vilcea.neighbors = [(sibiu, 80), (pitesti, 97), (craiova, 146)]
    timisoara.neighbors = [(lugoj, 111), (arad, 118)]
    lugoj.neighbors = [(timisoara, 111), (mehadia, 70)]
    mehadia.neighbors = [(lugoj, 70), (dobreta, 75)]
    dobreta.neighbors = [(mehadia, 75), (craiova, 120)]
    craiova.neighbors = [(dobreta, 120), (rimnicu_vilcea, 146), (pitesti, 138)]
    pitesti.neighbors = [(rimnicu_vilcea, 97), (craiova, 138), (bucharest, 101)]
    bucharest.neighbors = [(pitesti, 101), (giurgiu, 90), (urziceni, 85)]
    giurgiu.neighbors = [(bucharest, 90)]
    urziceni.neighbors = [(bucharest, 85), (hirsova, 98), (vaslui, 142)]
    hirsova.neighbors = [(urziceni, 98), (eforie, 86)]
    eforie.neighbors = [(hirsova, 86)]
    vaslui.neighbors = [(urziceni, 142), (iasi, 92)]
    iasi.neighbors = [(vaslui, 92), (neamt, 87)]
    neamt.neighbors = [(iasi, 87)]

    # Adding cities to the global lists and hash-table
    all_cities_list.extend([arad, zerind, oradea, sibiu, fagaras, rimnicu_vilcea, timisoara, lugoj, mehadia,
                            dobreta, craiova, pitesti, bucharest, giurgiu, urziceni, hirsova, eforie, vaslui, iasi, neamt])

    all_cities_hash = {city.name: city for city in all_cities_list}

# Function to get all city names from the list
def all_cities_from_list():
    return [city.name for city in all_cities_list]

# Function to get all city structures from the hash-table
def all_cities_from_hash():
    return list(all_cities_hash.values())

# Function to get a city structure from the list by name
def get_city_from_list(city_name):
    for city in all_cities_list:
        if city.name == city_name:
            return city
    return None  # City not found

# Function to get a city structure from the hash-table by name
def get_city_from_hash(city_name):
    return all_cities_hash.get(city_name, None)  # Returns None if not found

# Function to get neighbors using the list
def neighbors_using_list(city_name):
    city = get_city_from_list(city_name)
    if city:
        return city.neighbors
    return None  # City not found

# Function to get neighbors using the hash-table
def neighbors_using_hash(city_name):
    city = get_city_from_hash(city_name)
    if city:
        return city.neighbors
    return None  # City not found

# Function to get neighbors within a given distance
def neighbors_within_d(my_city_name, distance):
    my_city = get_city_from_hash(my_city_name)
    if my_city:
        neighbors_within_distance = [(neighbor.name, dist) for neighbor, dist in my_city.neighbors if dist <= distance]
        return neighbors_within_distance
    return None  # City not found

# Function to get distance between two cities
def neighbors_p(city_one_name, city_two_name):
    city_one = get_city_from_hash(city_one_name)
    city_two = get_city_from_hash(city_two_name)
    
    if city_one and city_two:
        for neighbor, dist in city_one.neighbors:
            if neighbor.name == city_two_name:
                return dist
    return None  # Cities not directly connected

# Breadth-First Search Tree Search
def bfs_tree_search(start_city, goal_city):
    start_time = time.time()
    nodes_generated = 0
    frontier = deque([(start_city, 0, 0, [start_city])])

    while frontier:
        current_city, cost, heuristic, path = frontier.popleft()
        nodes_generated += 1

        if current_city == goal_city:
            running_time = time.time() - start_time
            return {
                'path': path,
                'nodesGenerated': nodes_generated,
                'pathCost': cost,
                'runningTime': running_time
            }

        for neighbor, neighbor_cost in get_city_from_hash(current_city).neighbors:
            if neighbor.name not in path:
                new_path = path + [neighbor.name]
                frontier.append((neighbor.name, cost + neighbor_cost, 0, new_path))

    return {'path': [], 'nodesGenerated': nodes_generated, 'pathCost': 0, 'runningTime': 0}

# Breadth-First Search Graph Search
def bfs_graph_search(start_city, goal_city):
    start_time = time.time()
    nodes_generated = 0
    visited = [start_city]
    frontier = deque([(start_city, 0, 0, [start_city])])

    while frontier:
        current_city, cost, heuristic, path = frontier.popleft()
        nodes_generated += 1

        if current_city == goal_city:
            running_time = time.time() - start_time
            return {
                'path': path,
                'nodesGenerated': nodes_generated,
                'pathCost': cost,
                'runningTime': running_time
            }

        for neighbor, neighbor_cost in get_city_from_hash(current_city).neighbors:
            if neighbor.name not in visited:
                visited.append(neighbor.name)
                new_path = path + [neighbor.name]
                frontier.append((neighbor.name, cost + neighbor_cost, 0, new_path))

    return {'path': [], 'nodesGenerated': nodes_generated, 'pathCost': 0, 'runningTime': 0}

# Print Cities with Neighbors
def print_cities_with_neighbors():
    print(f"{'City': <20}|{'Heuristic': <10}|{'Neighbors'}")
    print("-" * 100)

    for city in all_cities_list:
        print(f"{city.name: <20}|h(n)={city.h: <5}|", end="")

        if city.neighbors:
            print("{", end=" ")
            for i, (neighbor, dist) in enumerate(city.neighbors):
                print(f"{neighbor.name} ({dist})", end="")
                if i < len(city.neighbors) - 1:
                    print(", ", end="")
            print(" }")
        else:
            print()

# Function to print a list of cities
def print_cities(cities, label):
    print(f"{label: <18}:", end=" ")
    print(" ".join(cities))

# Function to print search results
def print_search_result(algorithm, result):
    print(f"{algorithm} Search :  Search Result:")
    print(f"Path                          : {' '.join(result['path'])}")
    print(f"Nodes Visited       : {result['nodesGenerated']}")
    print(f"Path Cost                     : {result['pathCost']}")
    print(f"CPU Time                  : {result['runningTime']:.7f} seconds\n")

# Test Breadth-First Search
def test_bfs():
    bfs_tree_result = bfs_tree_search("Arad", "Bucharest")
    bfs_graph_result = bfs_graph_search("Arad", "Bucharest")

    print_search_result("BFS Tree", bfs_tree_result)
    print_search_result("BFS Graph", bfs_graph_result)

# Call functions
complete_the_graph()
print_cities_with_neighbors()
test_bfs()
