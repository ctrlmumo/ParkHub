CREATE TABLE users (
  id INT PRIMARY KEY AUTO_INCREMENT,
  username VARCHAR(100) NOT NULL,
  email VARCHAR(150) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  is_admin BOOLEAN NOT NULL DEFAULT FALSE,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE parking_lots (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  location VARCHAR(150) NOT NULL,
  admin_id INT NOT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

  CONSTRAINT fk_parking_lot_admin
    FOREIGN KEY (admin_id) REFERENCES users(id)
);

CREATE TABLE parking_slots (
  id INT PRIMARY KEY AUTO_INCREMENT,
  parking_lot_id INT NOT NULL,
  slot_number VARCHAR(20) NOT NULL,
  status VARCHAR(20) NOT NULL CHECK (status IN ('available', 'reserved', 'occupied')),
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

  CONSTRAINT fk_slot_parking_lot
    FOREIGN KEY (parking_lot_id) REFERENCES parking_lots(id),

  CONSTRAINT uq_lot_slot UNIQUE (parking_lot_id, slot_number)
);

CREATE TABLE reservations (
  id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT NOT NULL,
  parking_slot_id INT NOT NULL,
  start_time DATETIME NOT NULL,
  end_time DATETIME NOT NULL,
  status VARCHAR(20) NOT NULL CHECK (status IN ('active', 'cancelled', 'completed')),
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

  CONSTRAINT fk_reservation_user
    FOREIGN KEY (user_id) REFERENCES users(id),

  CONSTRAINT fk_reservation_slot
    FOREIGN KEY (parking_slot_id) REFERENCES parking_slots(id),

  CONSTRAINT chk_time_valid
    CHECK (end_time > start_time)
);


/* Relationships */

Ref: users.id < user_profiles.user_id

Ref: users.id < parking_lots.admin_id

Ref: parking_lots.id < parking_slots.parking_lot_id

Ref: users.id < reservations.user_id

Ref: parking_slots.id < reservations.parking_slot_id
