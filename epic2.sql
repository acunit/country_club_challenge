-- Produce a list of start times for bookings by members named 'David Farrell'?
--
-- Hint: Remember that a JOIN is selecting all records from Table A and Table B, where the join condition is met.
SELECT
  b.member_id,
  b.start_time
FROM bookings b JOIN members m ON (m.id = b.member_id)
WHERE surname = 'Farrell' AND first_name = 'David';

-- Produce a list of the start times for bookings for tennis courts, for the date '2016-09-21'? Return a list of start time and facility name pairings, ordered by the time.
--
-- Hint: In the WHERE clause use IN. See Example IN Operator
SELECT
  b.start_time,
  f.name
FROM
  bookings b JOIN facilities f ON (f.id = b.facility_id)
WHERE
  to_char(b.start_time, 'YYYY-MM-DD') IN ('2012-09-21')
ORDER BY
  b.start_time ASC;

  -- Produce a list of all members who have used a tennis court? Include in your output the name of the court, and the name of the member formatted as first name, surname. Ensure no duplicate data, and order by the first name.
  --
  -- Hint: This will require two JOINs
  -- Example:
  --   FROM
  --     ... ...
  --       JOIN ... ...
  --          ON ... = ...
  --       JOIN ... ...
  --          ON ... = ...
  --   WHERE
  --     ... IN ...

SELECT
  m.first_name,
  m.surname,
  f.name
FROM
  members m JOIN
  bookings b ON (b.member_id = m.id) JOIN
  facilities f ON (f.id = b.facility_id)
WHERE
  b.facility_id <= 1;

-- Produce a number of how many times Nancy Dare has used the pool table facility?
WITH nancy_pool_table_visits AS
    (SELECT
      m.first_name,
      m.surname,
      f.name AS facility
    FROM
      members m JOIN
      bookings b ON (b.member_id = m.id) JOIN
      facilities f ON (f.id = b.facility_id)
    WHERE
      m.first_name = 'Nancy'
      AND
      m.surname = 'Dare'
      AND
      f.name = 'Pool Table')
SELECT
  first_name,
  surname,
  facility,
  count(facility) AS times_visited
FROM
  nancy_pool_table_visits
GROUP BY
  first_name,
  surname,
  facility;


-- Produce a list of how many times Nancy Dare has visited each country club facility.
WITH nancy_facility_visits AS
    (SELECT
      m.first_name,
      m.surname,
      f.name AS facility
    FROM
      members m JOIN
      bookings b ON (b.member_id = m.id) JOIN
      facilities f ON (f.id = b.facility_id)
    WHERE
      m.first_name = 'Nancy'
      AND
      m.surname = 'Dare')
SELECT
  first_name,
  surname,
  facility,
  count(facility) AS times_visited
FROM
  nancy_facility_visits
GROUP BY
  first_name,
  surname,
  facility;


-- Produce a list of all members who have recommended another member? Ensure that there are no duplicates in the list, and that results are ordered by (surname, firstname).
--
-- Hint: SELF JOIN The tables we are joining don't have to be different tables. We can join a table with itself. This is called a self join. In this case we have to use aliases for the table otherwise PostgreSQL will not know which id column of which table instance we mean.
-- Example:
-- FROM tacos ...
--     JOIN tacos ...
--       ON ... = ...
SELECT
  m1.first_name,
  m1.surname
FROM members m1, members m2
WHERE
  m1.recommended_by IS NOT NULL
GROUP BY
  m1.first_name,
  m1.surname;

-- Output a list of all members, including the individual who recommended them (if any), without using any JOINs? Ensure that there are no duplicates in the list, and that member is formatted as one column and ordered by member.
--
-- Hint: To concatenate two columns to look like one you can use the ||
-- Example: SELECT DISTINCT ... || ' ' || ... AS ...,
-- Hint: See Subqueries Here and Here
-- Example:
-- SELECT DISTINCT ... || ' ' ||  ... AS ....,
--     (SELECT ... || ' ' || ... AS ....
--         FROM ... ...
--         WHERE ... = ...
--     ) FROM ... ...
