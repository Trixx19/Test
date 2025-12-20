import { Star } from 'lucide-react';

interface StarRatingProps {
    rating: number;
    setRating: (rating: number) => void;
}

export function StarRating({ rating, setRating }: StarRatingProps) {
    return (
        <div className="flex gap-2 justify-center py-4">
            {[1, 2, 3, 4, 5].map((star) => (
                <button
                    key={star}
                    type="button"
                    onClick={() => setRating(star)}
                    className="transition-transform active:scale-90"
                >
                    <Star
                        size={32}
                        className={`${star <= rating ? 'fill-blue-500 text-blue-500' : 'text-zinc-700 hover:text-zinc-500'
                            } transition-colors duration-200`}
                    />
                </button>
            ))}
        </div>
    );
}