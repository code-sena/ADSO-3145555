using CafetinSena.Domain.Interfaces;
using Microsoft.AspNetCore.Mvc;
using CafetinSena.Application.IService;
using CafetinSena.Application.DTOs.DtoProducto;


namespace CafetinSena.API.Controllers
{
    [ApiController] // nos indiuca que esta clase en un controllador
    [Route("api/[controller]")] // url del api 
    public class ProductoController : ControllerBase
    {
        private readonly IProductoService service;
        public ProductoController(IProductoService service)
        {
            this.service = service;
        }
        [HttpGet]
        public async Task<IActionResult> Get()
        {
            var productos = await service.listarProductos();
            return Ok(productos);
        }
        [HttpGet("{id}")]
        public async Task<IActionResult> Get(int id)
        {
            var producto = await service.obtenerPorId(id);
            if (producto == null)
                return NotFound();
            return Ok(producto);
        }
        [HttpPost]
        public async Task<IActionResult> Post([FromBody] ProductoCreateDto productoCreateDto)
        {
            var producto = await service.crearProducto(productoCreateDto);
            return CreatedAtAction(nameof(Get), new { id = producto.Id }, producto);


        }
    }
}
