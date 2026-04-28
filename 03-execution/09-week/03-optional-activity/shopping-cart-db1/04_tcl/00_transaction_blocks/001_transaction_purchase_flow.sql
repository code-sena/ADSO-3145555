-- ============================================================
-- TCL – Full purchase transaction block
-- Creates a bill with items, deducts inventory, records payment
-- Uses SAVEPOINT for partial rollback capability
-- ============================================================

BEGIN;

  -- 1. Create the bill
  INSERT INTO bill.bill (user_id, total, created_by)
  SELECT
    u.id,
    0,
    'tcl-demo'
  FROM security."user" u
  WHERE u.username = 'silent-wolf-0001'
  LIMIT 1;

  SAVEPOINT sp_bill_created;

  -- 2. Add bill items
  INSERT INTO bill.bill_item (bill_id, product_id, quantity, unit_price, total, created_by)
  SELECT
    b.id,
    p.id,
    2,
    p.price,
    p.price * 2,
    'tcl-demo'
  FROM bill.bill b
  CROSS JOIN inventory.product p
  WHERE b.created_by = 'tcl-demo'
    AND p.name = 'Laptop Pro 15'
  LIMIT 1;

  SAVEPOINT sp_items_added;

  -- 3. Update inventory (deduct stock)
  UPDATE inventory.inventory inv
  SET quantity   = quantity - 2,
      updated_at = NOW(),
      updated_by = 'tcl-demo'
  FROM inventory.product p
  WHERE inv.product_id = p.id
    AND p.name = 'Laptop Pro 15'
    AND inv.quantity >= 2;

  -- If no row was updated, inventory was insufficient – rollback to last savepoint
  -- (In a real app this check would use GET DIAGNOSTICS / exception handling)

  -- 4. Recalculate bill total
  UPDATE bill.bill b
  SET total      = (SELECT SUM(total) FROM bill.bill_item WHERE bill_id = b.id),
      updated_at = NOW(),
      updated_by = 'tcl-demo'
  WHERE b.created_by = 'tcl-demo';

COMMIT;
