using CafetinSena.Application.DTOs.DtoPedido;
using CafetinSena.Application.IService;
using Microsoft.AspNetCore.Mvc;

namespace CafetinSena.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class PedidoController : ControllerBase
    {

        private readonly IPedidoService _pedidoService;

        public PedidoController(IPedidoService pedidoService)
        {
            _pedidoService = pedidoService;
        }


        [HttpPost]
        public async Task<IActionResult> CrearPedido([FromBody] CrearPedidoDto dto)
        {
            if (!ModelState.IsValid)    
            {
                return BadRequest(ModelState);
            }
            
                await _pedidoService.CrearPedido(dto);
                return Ok(new { mensaje = "pedido creado correctamente"});
            }
        }
    }

