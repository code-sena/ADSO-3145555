using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CafetinSena.Application.DTOs.DtoProducto
{
    public class ProductoDto
    {
        public int Id {  get; set; }
        public string Nombre { get; set; }
        public decimal Precio { get; set; }
        public int Stock {  get; set; }
    }
}
