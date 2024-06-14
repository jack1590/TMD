# TMD

Roku Example consuming The Movie Database (TMDb) API. For more information, visit the [TMDb API documentation](https://developers.themoviedb.org/3/getting-started/introduction).

## Installation

### Prerequisites

- Node.js (minimum supported version is 16)

### Steps

1. **Install Node.js**: Ensure you have Node.js installed on your system. The minimum supported version is 16.

2. **Install Dependencies**:
    Open your terminal and run the following command to install the necessary dependencies:
    ```bash
    npm install
    ```

3. **Configure Environment Variables**:
    - Create a `.env` file in the root directory of your project.
    - Use the `example.env` file as a reference for the required environment variables.
    - Create an account on [The Movie Database](https://www.themoviedb.org/) to obtain an access token.
    - Add your TMD access token to the `.env` file as follows:
      ```plaintext
      TMD_ACCESS_TOKEN=your_access_token_here
      ```
4. **Main Concepts**:
    - The project is built using the BrighterScript compiler to catch runtime errors during the compilation phase.
    - BSLint is implemented to enforce code style and avoid common issues.
    - The application is developed for Full HD (FHD) resolution.
