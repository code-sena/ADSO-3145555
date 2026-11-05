using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CafetinSena.Application.DTOs.DtoProducto
{
    public class ProductoCreateDto
    {
        

        [Required(ErrorMessage = "El nombre es obligatorio")]
        [StringLength(100)]
        public string Nombre { get; set; }


        [Required(ErrorMessage = "El stock es obligatorio")]
        [Range(0.01, double.MaxValue, ErrorMessage = "el precio debe ser mayor que 0")]
        public decimal Precio { get; set; }

        [Required(ErrorMessage ="el Stock es obligatorio")]
        [Range(0, int.MaxValue,ErrorMessage ="el stock no debe ser negativo")]
        public int Stock { get; set; }
        
    }
}
