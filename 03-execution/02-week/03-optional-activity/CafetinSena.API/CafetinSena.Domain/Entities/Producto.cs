using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CafetinSena.Domain.Entities
{
    [Table("Productos")]
    public class Producto
    {
        public int Id { get; set; }
        public required string Nombre { get; set; }
        public decimal Precio { get; set; }
        public int Stock { get; set; }
        public bool Disponible { get; set; }
        public DateTime FechaCreacion { get; set; }
        public bool Eliminado { get; set; }
    }
}
