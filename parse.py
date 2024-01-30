# A Python script to parse all result files in the results/ directory.
# Each result file has a .out extension.
# They are located at different levels of the directory tree.

import glob
import re
import pandas as pd

# Get all result files with glob
result_files = glob.glob('**/*.out', recursive=True)

# Initialize a dictionary to store the results with a list for each metric
results = {
    'map': [],
    'scenario': [],
    'agents': [],
    'connectivity': [],
    'flowtime': [],
    'runtime': [],
}

# Open each file and parse the results
for file in result_files:
    with open(file, 'r') as f:
        # Read lines
        lines = f.readlines()
        # Continue only for file with "Soulution found: true" as the first line
        if lines[0].strip() == "Soulution found: true":
            # Here is an example file:
            # Soulution found: true
            # Runtime: 0.355327
            # Makespan: 320
            # Flowtime: 3249
            # Initial Cost: 3249
            # Collision Checking Time: 0.263718
            # HL expanded: 20
            # LL searches: 164
            # LL expanded(avg): 580.25

            # Get the flowtime
            flowtime = float(lines[3].split(':')[1].strip())

            # Get the map name, which is the parent directory name
            map_name = file.split('/')[-2]
            
            # The file name gives the scenario name, the number of agents considered, and optionally the connectivity of the graph.
            # It is of the form: <scenario>-<agents>.out or <scenario>-<agents>-c<connectivity>.out
            # Let's create a regex to parse this.
            regex = r'(.*)-(\d+)(?:-c(\d+))?.out'
            matches = re.search(regex, file.split('/')[-1])
            scenario = matches.group(1)
            agents = matches.group(2)
            connectivity = matches.group(3)

            # Get the runtime
            runtime = float(lines[1].split(':')[1].strip())
            
            # Add the results to the dictionary
            results['map'].append(map_name)
            results['scenario'].append(scenario)
            results['agents'].append(agents)
            results['connectivity'].append(connectivity)
            results['flowtime'].append(flowtime)
            results['runtime'].append(runtime)

# Create a dataframe from the dictionary
df = pd.DataFrame(results)

# Sort the dataframe by map, scenario, agents, connectivity
df = df.sort_values(['map', 'scenario', 'agents', 'connectivity'])

# Save the dataframe to a csv file
df.to_csv('results.csv', index=False)

