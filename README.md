# Advanced Data Warehousing (ADW) - E1
## Practical Development

**Project Overview**:  
This project focuses on the comparative performance of InnoDB and MyISAM storage engines in MySQL under various test conditions. Using this repository, users can set up their environments and run benchmarks to analyze the speed of these storage engines under different concurrent client loads and data entry counts.

### Prerequisites:

1. **MySQL Database**:
    - Ensure it's running on port `3306`.
    - Set up with the credentials: username = `adw` and password = `adw`.
    - Assign necessary permissions to the user:
      ```sql
      mysql> CREATE USER 'adw'@'%' IDENTIFIED BY 'adw';
      mysql> GRANT ALL PRIVILEGES ON *.* TO 'adw'@'%' WITH GRANT OPTION;
      ```
2. **`jq` Tool**: This lightweight and flexible command-line JSON processor is essential for handling JSON outputs. Install it using:
    ```bash
    sudo apt install jq
    ```
3. **Python Environment**: Ensure you have Python 3.8 or higher installed.

### Running the Benchmark Tests:

Based on the test volume you aim to execute, run one of the following commands from the project root:

- For comprehensive testing:
    ```bash
    ./run-all-tests-json.sh
    ```

- For a quick demo:
    ```bash
    ./run-demo-tests-json.sh
    ```

Upon execution, test results will be conveniently stored in the `Resultados` directory in a structured JSON format.

### Test Results Structure:

The output provides detailed timings in seconds. These timings allow users to understand the performance variances between InnoDB and MyISAM storage engines. Results are grouped by:
- Storage Engine Type (InnoDB or MyISAM)
- Number of data entries
- Number of concurrent clients executing queries

For instance:
```json
{
  "InnoDB_times": {
    "100 Entries": {
      "4 Concurrent Clients": 0.0009200,
      "8 Concurrent Clients": 0.0012500
    }
  },
  "MyISAM_times": {
    ...
  }
}
```

### Insights:
- The benchmarks are designed to give a holistic view of how MySQL's storage engines perform under different conditions.
- From initial results, users might notice that InnoDB and MyISAM have distinct performance characteristics, especially as the number of concurrent clients increases.
- It's essential to choose the right storage engine based on the specific needs of your application, whether it prioritizes read-heavy operations, write-heavy tasks, or a balanced mix.

### Future Work:
- Expand the benchmarks to include more storage engines.
- Incorporate metrics like CPU and Memory utilization during test runs.
- Provide visualization tools/scripts to plot performance graphs from the JSON outputs.

### Contributing:
We welcome contributions! If you'd like to improve the benchmarking scripts, offer more insights, or add more storage engine tests, please open a pull request or issue.
