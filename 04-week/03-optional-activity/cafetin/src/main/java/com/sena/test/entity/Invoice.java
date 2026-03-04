@Entity
@Table(name = "invoice")
@Data
public class Invoice {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "invoice_number", unique = true)
    private String invoiceNumber;

    private Double total;

    @Column(name = "pago_con")
    private Double pagoCon;

    private Double cambio;

    @OneToOne
    @JoinColumn(name = "order_id")
    private Order order; // Debes tener la entidad Order creada
}