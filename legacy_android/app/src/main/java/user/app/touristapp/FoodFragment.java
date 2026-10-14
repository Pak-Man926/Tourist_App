package user.app.touristapp;

import android.os.Bundle;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import java.util.ArrayList;
import java.util.List;


public class FoodFragment extends Fragment {

    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_food, container, false);

        RecyclerView recyclerView = view.findViewById(R.id.recyclerView);
        recyclerView.setLayoutManager(new LinearLayoutManager(getContext()));

        List<TouristSpot> spots = new ArrayList<>();
        spots.add(new TouristSpot("Ard Bia", "A cozy spot for Irish cuisine.", R.drawable.ard_bia));
        spots.add(new TouristSpot("McDonagh’s", "Famous for its fish and chips.", R.drawable.mcdonaghs));
        spots.add(new TouristSpot("Kai Restaurant", "A trendy place for food lovers.", R.drawable.kai_restaurant));
        spots.add(new TouristSpot("An Púcán", "Traditional Irish food with a lively atmosphere.", R.drawable.an_pucan));
        spots.add(new TouristSpot("The Dough Bros", "Award-winning wood-fired pizza in Galway.", R.drawable.dough_bros));
        spots.add(new TouristSpot("Salt House", "Trendy spot known for gin and gourmet food.", R.drawable.salt_house));

        TouristSpotAdapter adapter = new TouristSpotAdapter(getContext(), spots);
        recyclerView.setAdapter(adapter);

        return view;
    }
}