# CHANGES

- ## January 18, 2025

    - ### `Phase 1` Core Structure _(Completed)_

        > Provide a solid foundation for byte operations and ensure full UTF-8 support, including both static and dynamic types to handle all use cases.

    - **Deliverables:**

        - **Utils:**
          - `io.utils.bytes`
          - `io.utils.utf8`

        - **Types:**
          - `io.types.Viewer`
          - `io.types.Buffer`
          - `io.types.String`
          - `io.types.uString`

- ## January 19, 2025

    - ### `Phase 2` Read-Only Functions _(Completed)_

        > Implement advanced read-only functions that don't modify the data directly but enhance usability.

      - **Deliverables:**

        > More than **50** _(total added functions for all sections)_ read-only functions have been added to all sections (types and utilities).

- ## January 22, 2025

    - ### `Phase 3` Insertion Functions _(Completed)_

        > Add support for functions that allow inserting elements or data into the types.

      - **Deliverables:**

        > More than **50** _(total added functions for all sections)_ insertion functions have been added to all sections (types and utilities).

- ## January 27, 2025

    - ### `Phase 4` Deletion Functions _(Completed)_

        > Provide robust functions for removing elements or slices of data from the types.

      - **Deliverables:**

        > More than **25** _(total added functions for all sections)_ remove functions have been added to all sections (types and utilities).

        > Codes have been reduced and performance has been greatly improved.

        > Benchmarks have been performed and a `bench` section has been added to the documentation.

- ## January 28, 2025

    - ### `Phase 5` Split Functions _(Completed)_

        > Functionality to split strings into substrings based on a delimiter.

      - **Deliverables:**

        > More than **20** _(total added functions for all sections)_ split functions have been added to all sections (types and utilities).

        > Codes have been reduced.

    - **Todo:**

        - ### `Phase 6` Standard Library Integration

            > Add commonly used utility functions to align with Zig's standard library conventions, ensuring compatibility and ease of integration.

