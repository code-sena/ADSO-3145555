using CafetinSena.Application.DTOs.DtoPedido;
using CafetinSena.Application.IService;
using CafetinSena.Domain.Interfaces.IRepository;


namespace CafetinSena.Application.Service
{
    public class PedidoService : IPedidoService
    {
        private readonly IPedidoRepository _pedidoRepository;


        public PedidoService(IPedidoRepository pedidoRepository)
        {
            _pedidoRepository = pedidoRepository;
        }

        public async Task CrearPedido(CrearPedidoDto dto)
        {
            var pedido = Mappers.PedidoMapeer.ToEntity(dto);
            await _pedidoRepository.AgregarAsync(pedido);
            await _pedidoRepository.GuardarAsync();


        }
       
    }
}
