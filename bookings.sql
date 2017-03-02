CREATE TABLE bookings (
  id serial PRIMARY KEY,
  facility_id integer REFERENCES facilities(id),
  member_id integer REFERENCES members(id),
  start_time timestamp,
  slots integer
  );
