-- Query 1
SELECT quantityOnHand 
FROM item 
WHERE itemDescription='bottle of antibiotics';

-- Query 2
SELECT volunteerName 
FROM volunteer 
WHERE volunteerName NOT LIKE '%Jones' 
AND volunteerTelephone NOT LIKE '2%';

-- Query 3
SELECT volunteer.volunteerName 
FROM volunteer AS volunteer
JOIN assignment AS assignment
ON volunteer.volunteerId = assignment.volunteerId
JOIN task AS task
ON task.taskCode = assignment.taskCode
JOIN task_type as task_type
ON task.taskTypeId = task_type.taskTypeId
WHERE task_type.taskTypeName = 'transporting';

-- Query 4
SELECT taskDescription 
FROM task AS task
LEFT JOIN assignment AS assignment
ON assignment.taskCode = task.taskCode
WHERE volunteerId IS NULL;

-- Query 5
SELECT DISTINCT packageTypeName
FROM package_type AS package_type
JOIN package AS package
ON package.packageTypeId = package_type.packageTypeId
JOIN package_contents AS package_contents
ON package.packageId = package_contents.packageId
JOIN item AS item
ON package_contents.itemId = item.itemId
WHERE item.itemDescription LIKE '%bottle%';

-- Query 6
SELECT itemDescription
FROM item AS item
LEFT JOIN package_contents
ON package_contents.itemId = item.itemId
WHERE package_contents.packageId IS NULL;

-- Query 7
SELECT DISTINCT taskDescription
FROM task
JOIN assignment
ON task.taskCode = assignment.taskCode
JOIN volunteer 
ON volunteer.volunteerId = assignment.volunteerId
WHERE volunteerAddress LIKE '%NJ%';

-- Query 8
SELECT DISTINCT volunteerName 
FROM volunteer
JOIN assignment 
ON volunteer.volunteerId = assignment.volunteerId
WHERE assignment.startDateTime >= '2021-01-01' AND assignment.startDateTime < '2021-07-01';

-- Query 9
SELECT DISTINCT volunteerName
FROM volunteer
JOIN assignment
ON volunteer.volunteerId = assignment.volunteerId
JOIN task 
ON task.taskCode = assignment.taskCode
JOIN package
ON package.taskCode = task.taskCode
JOIN package_contents
ON package.packageId = package_contents.packageId
JOIN item
ON item.itemId = package_contents.itemId
WHERE item.itemDescription LIKE '%spam%';

-- Query 10
SELECT itemDescription
FROM item
JOIN package_contents 
ON package_contents.itemId = item.itemId
WHERE package_contents.itemQuantity * item.itemValue = 100;

-- Query 11
SELECT taskStatusName,COUNT(DISTINCT volunteerId) as volunteers
FROM assignment
JOIN task
ON task.taskCode = assignment.taskCode
JOIN task_status
ON task_status.taskStatusId = task.taskStatusId
GROUP BY task.taskStatusId
ORDER BY volunteers DESC;

-- Query 12
SELECT task.taskCode,SUM(packageWeight)
FROM package 
JOIN task
ON task.taskCode = package.taskCode
GROUP BY task.taskCode
ORDER BY SUM(packageWeight) DESC
LIMIT 1;

-- Query 13
SELECT COUNT(*)
FROM task
JOIN task_type 
ON task_type.taskTypeId = task.taskTypeId
WHERE taskTypeName != 'packing';

-- Query 14
SELECT itemDescription
FROM item
RIGHT JOIN package_contents
ON item.itemId = package_contents.itemId
JOIN package
ON package_contents.packageId = package.packageId
JOIN task
ON task.taskCode = package.taskCode
JOIN assignment
ON assignment.taskCode = task.taskCode 
GROUP BY item.itemId
HAVING COUNT(DISTINCT volunteerId) < 3;

-- Query 15
SELECT package.packageId,SUM(itemValue*itemQuantity) as value
FROM package
JOIN package_contents
ON package_contents.packageId = package.packageId
JOIN item 
ON package_contents.itemId = item.itemId
GROUP BY package.packageId
HAVING value>100
ORDER BY value;
