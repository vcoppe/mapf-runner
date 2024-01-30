import pandas as pd

# load results from parse.py with columns: map, scenario, agents, connectivity, flowtime
df = pd.read_csv('results.csv')

# replace map names 'sparse', 'dense' and 'super-dense' with 'roadmaps/sparse', 'roadmaps/dense' and 'roadmaps/super-dense'
df['map'] = df['map'].replace(['sparse', 'dense', 'super-dense'], ['roadmaps/sparse', 'roadmaps/dense', 'roadmaps/super-dense'])

# replace missing connectivity with 2
df['connectivity'] = df['connectivity'].fillna(value=2)

# remove rows with connectivity different from 2
df = df[df.connectivity == 2]

# remove rows with runtime > 0.1
df = df[df.runtime <= 0.05]

# get the maximum number of agents for each map and scenario
max_agents = df.groupby(['map', 'scenario']).max()['agents']

# for each map and scenario, get the row with either maximum number of agents
df = df[df.apply(lambda row: row['agents'] == max_agents[row['map'], row['scenario']], axis=1)]

# for each row in the dataframe, print a test case of the form:
# #[test]
# fn <map>_<scenario>_<agents>() {
#     assert!((solve(<map>, <scenario>, "config-2.xml", <agents>).0 - <flowtime>).abs() < 1e-3);
# }
# where <map>, <scenario>, <agents>, and <flowtime> are the values in the row
# and '-' is replaced with '_' in the test name
for index, row in df.iterrows():
    print(f"#[test]")
    print(f"fn {row['map'].replace('-', '_').replace('/', '_')}_{row['scenario'].replace('-', '_')}_{row['agents']}() {{")
    print(f"    assert!((solve(\"{row['map']}\", \"{row['scenario']}.xml\", \"config-2.xml\", {row['agents']}).0 - {row['flowtime']}).abs() / {row['flowtime']} < 1e-2);")
    print(f"}}")
    print()