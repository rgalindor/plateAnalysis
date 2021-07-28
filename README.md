# plateAnalysis

These scripts can be used together to calculate AUC of the values of a tabular file. The structure of this file tipically is produced by devices that measure absorbance of 96 well plates. The values obtained can be originated in experiments that require to measure quantity of cells that are present in a sample well. So this software can measure at different time snapshots the change in population size of certain types of microbes.

This is the structure of data that can be used:

| Time | Well 01 | Well 02 | ... |
|---|---|---|---|
| 00:00:00 | 0.08 | 0.07 | ... |
| ... | ... | ... | ... |


