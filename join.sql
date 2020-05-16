CREATE TABLE students(
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100)
);

CREATE TABLE papers(
    title VARCHAR(100),
    grade INT,
    student_id INT,
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE
);


INSERT INTO students (first_name) VALUES 
('Caleb'), ('Samantha'), ('Raj'), ('Carlos'), ('Lisa');

INSERT INTO papers (student_id, title, grade ) VALUES
(1, 'My First Book Report', 60),
(1, 'My Second Book Report', 75),
(2, 'Russian Lit Through The Ages', 94),
(2, 'De Montaigne and The Art of The Essay', 98),
(4, 'Borges and Magical Realism', 89);

-- EXERCISE 1
SELECT first_name, title, grade
FROM students
INNER JOIN papers
    ON students.id = papers.student_id
ORDER BY grade DESC;

-- EXERCISE 2
SELECT first_name, title, grade
FROM students
LEFT JOIN papers
  ON students.id = papers.student_id;
  
-- EXERCISE 3
SELECT 
  first_name,
  IFNULL(title,'MISSING'),
  IFNULL(grade, 0)
FROM students
LEFT JOIN papers
  ON students.id = papers.student_id;
  
-- EXERCISE 4
SELECT 
  first_name,
  IFNULL(AVG(grade), 0) AS average
FROM students
LEFT JOIN papers
  ON students.id = papers.student_id
GROUP BY students.id
ORDER BY average DESC;

-- EXERCISE 5
SELECT 
  first_name,
  IFNULL(AVG(grade), 0) AS average
  CASE  
      WHEN AVG(grade) IS NULL THEN 'FAILING'
      WHEN AVG(grade) >= 75 THEN 'PASSING'
      ELSE 'FAILING'
  END AS passing_status
FROM students
LEFT JOIN papers
  ON students.id = papers.student_id
GROUP BY students.id
ORDER BY average DESC;
    