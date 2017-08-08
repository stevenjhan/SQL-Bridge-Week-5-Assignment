/*
Steven Han - steven.han@nbcuni.com
Week 5 Assignment – Self-Joins

Please create an organization chart for a real or imagined organization, implemented in a single SQL table. Your
deliverable script should:
1. Create the table. Each row should minimally include the person’s name, the person’s supervisor, and the
person’s job title. Using ID columns is encouraged.
2. Populate the table with a few sample rows.
3. Provide a single SELECT statement that displays the information in the table, showing who reports to whom
*/

CREATE SCHEMA IF NOT EXISTS assignment_5;

USE assignment_5;

DROP TABLE IF EXISTS potus;

# Create potus table

CREATE TABLE potus
(
	employee_title VARCHAR(200) NOT NULL,
    employee_name VARCHAR(100) NOT NULL,
    employee_id INT NOT NULL PRIMARY KEY,
    manager_id INT NULL
);

INSERT INTO potus
(employee_title, employee_name, employee_id, manager_id)
VALUES
("President", "Donald J. Trump", 1, NULL),
("Chief of Staff", "Reince Priebus", 2, 1),
("Deputy Chief of Staff", "Katie Walsh", 74, 2),
("Deputy Chief of Staff for Operations", "Joe Hagin", 73, 2),
("Deputy Chief of Staff for Policy", "Rick Dearborn", 72, 2),
("Chief Strategist and Senior Counselor to the President", "Stephen K. Bannon", 3, 1),
("Senior White House Advisor", "Jared Kushner", 4, 1),
("Special Assistant to the President and Assistant to the Senior Advisor", "Avrahm Berkowitz", 71, 4),
("Assistant to the President and Senior Advisor to the President for Policy", "Stephen Miller", 34, 1),
("Assistant to the President and White House Counsel", "Donald F. McGahn", 35, 1),
("Counselor to the President", "Kellyanne Conway", 36, 1),
("Assistant to the President and Director of Legislative Affairs", "Marc Short", 37, 1),
("Assistant to the President and Director of Presidential Personnel", "John DeStefano", 38, 1),
("Assistant to the President and Director of Communications for the Office of Public Liaison", "Omarosa Manigault", 39, 1),
("Assistant to the President for Intragovernmental and Technology Initiatives", "Reed Cordish", 40, 1),
("Assistant to President and Chief of Staff to the Vice President", "Josh Pitcock", 41, 1),
("Assistant to the President and Staff Secretary", "Rob Porter", 42, 1),
("Deputy Assistant to the President and Director of Oval Office Operations", "Keith Schiller", 43, 1),
("Deputy Assistant to the President and Director of Advance", "George Gigicos", 44, 1),
("Deputy Assistant to the President and Political Director", "Bill Stepien", 45, 1),
("Deputy Assistant to the President and Cabinet Secretary", "Bill McGinley", 46, 1),
("Deputy Assistant to the President and Director of Intergovernmental Affairs", "Justin Clark", 47, 1),
("Deputy Assistant to the President and Deputy Chief of Staff to the Vice President", "Jen Pavlik", 48, 1),
("Special Assistant to the President and Personal Aide to the President", "John McEntee", 49, 1),
("Executive Assistant to the President", "Madeleine Westerhout", 50, 1),
("Chief Digital Officer", "Gerrit Lansing", 51, 1),
("Press Secretary/Communications Director", "Sean Spicer", 5, 1),
("Deputy Press Secretary and Adviser to the Press Secretary", "Lindsay Walters", 52, 5),
("Deputy Press Secretary", "Sarah Huckabee Sanders", 53, 5),
("Special Assistant to the President and Deputy Press Secretary", "Stephanie Grisham", 54, 53),
("Special Assistant to the President and Deputy Press Secretary and Advisor to the Press Secretary", "Lindsay Walters", 55, 52),
("Strategic Communications Director", "Hope Hicks", 56, 5),
("Social Media Director", "Dan Scavino", 57, 5),
("Deputy Assistant to the President and Deputy Communications Director", "Jessica Ditto", 58, 5),
("Deputy Assistant to the President and Deputy Communications Director and Research Director", "Raj Shah", 59, 5),
("Assistant Communications Director for Surrogate Operations", "Boris Epshteyn", 60, 5),
("Special Assistant to the President and Assistant Communications Director", "Steven Cheung", 61, 5),
("Special Assistant to the President and Director of Media Affairs", "Helen Aguirre Ferre", 62, 5),
("Special Assistant to the President and Assistant Communications Director for White House Message Strategy", "Cliff Sims", 63, 5),
("National Security Advisor", "Mike H. R. McMaster", 6, 1),
("Deputy National Security Advisor", "Ricky L. Waddell", 64, 6),
("Office of the Director of National Intelligence: Director", "Dan Coats", 7, 1),
("Homeland Security Advisor", "Thomas Bossert", 8, 1),
("National Security Council: Chief of Staff and Executive Secretary", "Keith Kellogg", 9, 1),
("National Economic Council: Director", "Gary Cohn", 10, 1),
("National Trade Council: Director", "Peter Navarro", 11, 1),
("National Trade Council: Deputy Director for the Defense Industrial Base", "Alexander Gray", 65, 11),
("National Trade Council: Deputy Director for “Buy American, Hire American” ", "Rolf Lundberg", 66, 11),
("National Trade Council: Special Representative for International Negotiations", "Jason Greenblatt", 67, 11),
("National Trade Council: Special Advisor to the President on Regulatory Reform", "Carl Icahn", 68, 11),
("Vice President", "Michael Pence", 12, 1),
("Assistant to President and Chief of Staff to the Vice President", "Josh Pitcock", 69, 12),
("Deputy Assistant to the President and Deputy Chief of Staff to the Vice President", "Jen Pavlik", 70, 12),
("Office of Management and Budget: Director", "Mick Mulvaney", 13, 1),
("Secretary of Agriculture", "Sonny Perdue", 14, 1),
("Secretary of Commerce", "Wilbur Ross", 15, 1),
("Secretary of Defense", "James Mattis", 16, 1),
("Secretary of Education", "Betsy DeVos", 17, 1),
("Secretary of Energy", "Rick Perry", 18, 1),
("Secretary of Health and Human Services", "Tom Price", 19, 1),
("Secretary of Homeland Security", "John Kelly", 20, 1),
("Secretary of Housing and Urban Development", "Ben Carson", 21, 1),
("Secretary of Interior", "Ryan Zinke", 22, 1),
("Secretary of Labor", "Andrew Puzder", 23, 1),
("Secretary of State", "Rex Tillerson", 24, 1),
("Secretary of Transportation", "Elaine Chao", 25, 1),
("Secretary of the Treasury", "Steven Mnuchin", 26, 1),
("Secretary of Veterans Affairs", "Dr. David J. Shulkin", 27, 1),
("Central Intelligence Agency: Director", "Mike Pompeo", 28, 1),
("Attorney General", "Jeff Sessions", 29, 1),
("Environmental Protection Agency: Administrator", "Scott Pruitt", 30, 1),
("Securities and Exchange Commission: Chairman", "Jay Clayton", 31, 1),
("Small Business Administration: Administrator", "Linda McMahon", 32, 1),
("United States Trade Representative", "Robert Lighthizer", 33, 1);

SELECT * FROM potus;

# Next, write SELECT statements that provide the following information:
# All groups, and the users in each group. A group should appear even if there are no users assigned to the group.
 
SELECT
Employee.employee_name AS `Employee Name`,
IFNULL(Manager.employee_name, 'POTUS') AS `Manager Name`

FROM potus AS Employee
LEFT JOIN potus AS Manager
ON Employee.manager_id = Manager.employee_id

ORDER BY `Employee Name`, `Manager Name`;
