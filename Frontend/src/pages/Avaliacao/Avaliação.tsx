import { useState } from 'react';
import { Send, MessageSquare, User, Mail } from 'lucide-react';
import { StarRating } from '../../components/StarRating/StarRating';
export function Avaliacao() {
    const [rating, setRating] = useState(0);

    return (
        <div className="min-h-screen bg-[#09090b] text-zinc-100 flex items-center justify-center p-6">
            <div className="w-full max-w-lg bg-zinc-900/50 border border-zinc-800 p-8 rounded-2xl backdrop-blur-md shadow-xl">

                <header className="mb-8 text-center">
                    <div className="inline-flex p-3 bg-blue-500/10 rounded-full mb-4">
                        <MessageSquare className="text-blue-500" size={28} />
                    </div>
                    <h1 className="text-3xl font-bold tracking-tight italic uppercase">Avaliação do Projeto</h1>
                    <p className="text-zinc-400 mt-2 text-sm">Sua opinião ajuda a melhorar nosso desenvolvimento.</p>
                </header>

                <form className="space-y-6" onSubmit={(e) => e.preventDefault()}>
                    <div className="space-y-2">
                        <label className="text-xs font-black uppercase text-zinc-500 tracking-widest">Nome Completo</label>
                        <div className="relative">
                            <User className="absolute left-3 top-3.5 text-zinc-600" size={18} />
                            <input type="text" placeholder="Seu nome" className="w-full bg-zinc-950 border border-zinc-800 rounded-lg pl-10 pr-4 py-3 focus:border-blue-500 outline-none transition-all" />
                        </div>
                    </div>

                    <div className="space-y-2">
                        <label className="text-xs font-black uppercase text-zinc-500 tracking-widest">E-mail</label>
                        <div className="relative">
                            <Mail className="absolute left-3 top-3.5 text-zinc-600" size={18} />
                            <input type="email" placeholder="seu@email.com" className="w-full bg-zinc-950 border border-zinc-800 rounded-lg pl-10 pr-4 py-3 focus:border-blue-500 outline-none transition-all" />
                        </div>
                    </div>

                    <div className="space-y-2 text-center">
                        <label className="text-xs font-black uppercase text-zinc-500 tracking-widest">Nota da Experiência</label>
                        <StarRating rating={rating} setRating={setRating} />
                    </div>

                    <div className="space-y-2">
                        <label className="text-xs font-black uppercase text-zinc-500 tracking-widest">Comentários</label>
                        <textarea rows={4} placeholder="O que você mais gostou?" className="w-full bg-zinc-950 border border-zinc-800 rounded-lg p-4 focus:border-blue-500 outline-none resize-none transition-all"></textarea>
                    </div>

                    <button className="w-full bg-zinc-100 text-zinc-950 font-black py-4 rounded-lg flex items-center justify-center gap-2 hover:bg-blue-600 hover:text-white transition-all uppercase tracking-tighter shadow-lg shadow-blue-500/10">
                        Enviar Avaliação <Send size={18} />
                    </button>
                </form>
            </div>
        </div>
    );
}