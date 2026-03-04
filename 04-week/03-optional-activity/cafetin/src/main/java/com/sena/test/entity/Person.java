@Entity
@Table(name = "person")
@Data
public class Person {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "first_name")
    private String firstName;

    @Column(name = "last_name")
    private String lastName;

    @Column(unique = true)
    private String email;

    @Column(name = "tipo_usuario")
    private String tipoUsuario;

    // RELACIÓN: Muchas personas tienen un mismo Tipo de Documento
    @ManyToOne
    @JoinColumn(name = "type_document_id")
    private TypeDocument typeDocument;

    // RELACIÓN: Muchas personas pertenecen a una misma Ficha
    @ManyToOne
    @JoinColumn(name = "ficha_id")
    private Ficha ficha;

    private Boolean status = true;
}