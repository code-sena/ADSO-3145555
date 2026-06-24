-- ============================================================
-- TCL – Manual recovery: reverse an erroneous bill
-- Use when a bill was committed with wrong amounts
-- ============================================================

BEGIN;

  -- Identify the erroneous bill (replace the UUID)
  -- ROLLBACK TO SAVEPOINT cannot cross a COMMIT, so we use compensating DML

  -- 1. Zero out the bill total
  UPDATE bill.bill
  SET total      = 0,
      state      = 'CANCELLED',
      updated_at = NOW(),
      updated_by = 'manual-recovery'
  WHERE id = '00000000-0000-0000-0000-000000000000'; -- replace with real ID

  -- 2. Cancel all bill items
  UPDATE bill.bill_item
  SET state      = 'CANCELLED',
      updated_at = NOW(),
      updated_by = 'manual-recovery'
  WHERE bill_id = '00000000-0000-0000-0000-000000000000';

  -- 3. Restore inventory
  UPDATE inventory.inventory inv
  SET quantity   = quantity + bi.quantity,
      updated_at = NOW(),
      updated_by = 'manual-recovery'
  FROM bill.bill_item bi
  WHERE bi.product_id = inv.product_id
    AND bi.bill_id = '00000000-0000-0000-0000-000000000000';

COMMIT;
