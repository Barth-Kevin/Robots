Robots
- inspired by Robocorp

This is a public repository to complete Certificate II: Build a robot.

The task:
- The robot has to be able to order different robots from a .csv file at
    https://robotsparebinindustries.com/#/robot-order

-   Only the robot is allowed to get the orders file. You may not save the file manually on your computer.

-   The robot should save each order HTML receipt as a PDF file.

-   The robot should save a screenshot of each of the ordered robots.

-   The robot should embed the screenshot of the robot to the PDF receipt.

-   The robot should create a ZIP archive of the PDF receipts (one zip archive that contains all the PDF files). Store the archive in the output directory.

-   The robot should complete all the orders even when there are technical failures with the robot order website.

-   The robot should read some data from a local vault. In this case, do not store sensitive data such as credentials in the vault. The purpose is to verify that you know
    how to use the vault.

-   The robot should use an assistant to ask some input from the human user, and then use that input some way.

-   The robot should be available in public GitHub repository.

-   Store the local vault file in the robot project repository so that it does not require manual setup.

-   It should be possible to get the robot from the public GitHub repository and run it without manual setup.