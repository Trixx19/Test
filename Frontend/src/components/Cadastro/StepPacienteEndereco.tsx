import { useState } from 'react';

interface Props {
  data: any;
  onChange: (data: any) => void;
}

export function StepPacienteEndereco({ data, onChange }: Props) {
  const [loading, setLoading] = useState(false);
  
  const inputClass = "w-full bg-[#D9D9D9] bg-opacity-60 border-none rounded-full px-5 py-3 text-gray-700 placeholder-gray-500 focus:ring-2 focus:ring-yellow-400 outline-none disabled:opacity-50 disabled:cursor-not-allowed";
  const labelClass = "block text-sm mb-1 ml-4 text-gray-600";

  const handleCepChange = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const rawCep = e.target.value.replace(/\D/g, '');

    onChange({ cep: rawCep });

    if (rawCep.length === 8) {
      setLoading(true);
      try {
        const response = await fetch(`https://viacep.com.br/ws/${rawCep}/json/`);
        const addressData = await response.json();

        if (!addressData.erro) {
          onChange({
            cep: rawCep,
            endereco: addressData.logradouro,
            bairro: addressData.bairro,
            cidade: addressData.localidade,
            estado: addressData.uf,
            complemento: addressData.complemento || '',
          });
        } else {
          alert("CEP não encontrado!");
        }
      } catch (error) {
        console.error("Erro ao buscar CEP:", error);
      } finally {
        setLoading(false);
      }
    }
  };

  return (
    <div className="w-full max-w-4xl mx-auto animate-fadeIn">
      <h3 className="text-2xl font-bold text-center mb-8">Qual seu endereço?</h3>

      <div className="grid grid-cols-1 md:grid-cols-12 gap-6">
        
        {/* CEP */}
        <div className="md:col-span-5">
          <label className={labelClass}>
            CEP {loading && <span className="text-yellow-600 text-xs ml-2">(Buscando...)</span>}
          </label>
          <input 
            type="text" 
            placeholder="00000-000" 
            maxLength={9}
            className={inputClass}
            value={data.cep}
            onChange={handleCepChange}
          />
        </div>
        <div className="md:col-span-7"></div>

        <div className="md:col-span-6">
          <label className={labelClass}>Endereço</label>
          <input 
            type="text" 
            placeholder="Av. Washington Soares" 
            className={inputClass}
            value={data.endereco}
            onChange={e => onChange({ endereco: e.target.value })}
          />
        </div>

        <div className="md:col-span-2">
          <label className={labelClass}>Número</label>
          <input 
            type="text" 
            placeholder="1990" 
            className={inputClass}
            value={data.numero}
            onChange={e => onChange({ numero: e.target.value })}
          />
        </div>

        <div className="md:col-span-4">
          <label className={labelClass}>Complemento</label>
          <input 
            type="text" 
            placeholder="Bloco 2 ap 206" 
            className={inputClass}
            value={data.complemento}
            onChange={e => onChange({ complemento: e.target.value })}
          />
        </div>

        <div className="md:col-span-5">
          <label className={labelClass}>Bairro</label>
          <input 
            type="text" 
            placeholder="Cidade dos funcionários" 
            className={inputClass}
            value={data.bairro}
            onChange={e => onChange({ bairro: e.target.value })}
          />
        </div>

        <div className="md:col-span-4">
          <label className={labelClass}>Cidade*</label>
          <input 
            type="text" 
            placeholder="Fortaleza" 
            className={inputClass}
            value={data.cidade}
            onChange={e => onChange({ cidade: e.target.value })}
          />
        </div>

        <div className="md:col-span-3">
          <label className={labelClass}>Estado*</label>
          <input 
            type="text" 
            placeholder="CE" 
            className={inputClass}
            value={data.estado}
            onChange={e => onChange({ estado: e.target.value })}
          />
        </div>

      </div>
    </div>
  );
}