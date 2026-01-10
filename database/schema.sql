Table users {
  id int [pk, increment]
  username varchar
  email varchar
  password varchar
  is_admin boolean
  created_at datetime
}

Table user_profiles {
  id int [pk, increment]
  user_id int [unique, not null]
  phone varchar
  created_at datetime
}

Table parking_lots {
  id int [pk, increment]
  name varchar
  location varchar
  admin_id int [not null]
  created_at datetime
}

Table parking_slots {
  id int [pk, increment]
  parking_lot_id int [not null]
  slot_number varchar
  status ENUM('AVAILABLE','RESERVED','OCCUPIED')
  created_at datetime
}

Table reservations {
  id int [pk, increment]
  user_id int [not null]
  parking_slot_id int [not null]
  start_time datetime
  end_time datetime
  status ENUM('ACTIVE','CANCELLED','COMPLETED')
  // active, cancelled, completed
  created_at datetime
}

/* =========================
   Relationships
   ========================= */

Ref: users.id < user_profiles.user_id

Ref: users.id < parking_lots.admin_id

Ref: parking_lots.id < parking_slots.parking_lot_id

Ref: users.id < reservations.user_id

Ref: parking_slots.id < reservations.parking_slot_id
