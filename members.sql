CREATE TABLE members (
  id serial PRIMARY KEY,
  surname varchar,
  first_name varchar,
  address varchar,
  zipcode integer,
  telephone varchar,
  recommended_by integer REFERENCES members(id),
  join_date timestamp without time zone
  );
